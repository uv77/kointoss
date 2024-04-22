// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  late String _verificationId;
  bool _isOtpSent = false;

  Future<void> _verifyPhone() async {
    if (_phoneNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a phone number'),
        ),
      );
      return;
    }

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: '+91${_phoneNumberController.text}',
        // timeout: Duration(seconds: 300),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          print('Phone number automatically verified');
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Phone number verification failed: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Phone number verification failed: $e'),
            ),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          setState(() {
            _isOtpSent = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('OTP is Sent!!'),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      print('Failed to verify phone number: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to verify phone number: $e'),
        ),
      );
    }
  }

  Future<void> _submitOTP() async {
    if (_otpController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter the OTP'),
        ),
      );
      return;
    }

    try {
      // Verify the OTP
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _otpController.text,
      );

      await _auth.signInWithCredential(credential);
      // Get the currently signed-in user
      User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        // Create and link the email and password
        UserCredential emailCredential =
            await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // await currentUser.linkWithCredential(emailCredential.credential!);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Phone number ${currentUser.phoneNumber}and  email: ${emailCredential.user!.email} linked successfully'),
          ),
        );

        // Navigate to the home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(user: currentUser),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to link phone number and email'),
          ),
        );
      }
    } catch (e) {
      print('Failed to verify OTP and link phone number and email: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Failed to verify OTP and link phone number and email: $e'),
        ),
      );
    }
  }

  Future<void> _resendOTP() async {
    if (_phoneNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a phone number'),
        ),
      );
      return;
    }

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: '+91${_phoneNumberController.text}',
        // timeout: Duration(seconds: 300),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          print('Phone number automatically verified');
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Phone number verification failed: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Phone number verification failed: $e'),
            ),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          setState(() {
            _isOtpSent = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('OTP resent'),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      print('Failed to resend OTP: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to resend OTP: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 12),
              TextField(
                controller: _phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: _isOtpSent ? null : _verifyPhone,
                child: Text(_isOtpSent ? 'OTP Sent' : 'Verify Phone Number'),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _otpController,
                decoration: InputDecoration(labelText: 'OTP'),
                keyboardType: TextInputType.number,
                enabled: _isOtpSent,
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: _isOtpSent ? _submitOTP : null,
                child: Text('Submit OTP'),
              ),
              SizedBox(height: 30),
              TextButton(
                onPressed: _isOtpSent ? _resendOTP : null,
                child: Text('Resend OTP'),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
