// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCMdfpCTCi8IrfMLBgzBfns3Y5bhYMkjtE',
    appId: '1:592745716214:web:1736491a02a19a33f8cfd7',
    messagingSenderId: '592745716214',
    projectId: 'kointoss',
    authDomain: 'kointoss.firebaseapp.com',
    storageBucket: 'kointoss.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBvWKQRM0hBrvmEyC0GGlzMeRx7oDrTUqM',
    appId: '1:592745716214:android:a8866fa9da8375d6f8cfd7',
    messagingSenderId: '592745716214',
    projectId: 'kointoss',
    storageBucket: 'kointoss.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAwxN0ryyGbQzcm7_dP59N_qJw9_yQ-Ayw',
    appId: '1:592745716214:ios:83eab2e724eca851f8cfd7',
    messagingSenderId: '592745716214',
    projectId: 'kointoss',
    storageBucket: 'kointoss.appspot.com',
    iosBundleId: 'com.example.kointoss',
  );
}