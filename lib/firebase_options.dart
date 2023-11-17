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
    apiKey: 'AIzaSyBA1QmSiJG7oloPtpODSCPZSKsSAIHMsgo',
    appId: '1:259308116793:web:734c677022591270c5a6e8',
    messagingSenderId: '259308116793',
    projectId: 'password-manager-7fbaa',
    authDomain: 'password-manager-7fbaa.firebaseapp.com',
    storageBucket: 'password-manager-7fbaa.appspot.com',
    measurementId: 'G-SFJ14SY4NZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCVWwt5frbTjkkATgJ7l88NMeQFJNo-MJ4',
    appId: '1:259308116793:android:d09d48e17ce8cd47c5a6e8',
    messagingSenderId: '259308116793',
    projectId: 'password-manager-7fbaa',
    storageBucket: 'password-manager-7fbaa.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyArZohEPED2IuN01J9cHxv6kcZT2VMJAKw',
    appId: '1:259308116793:ios:f9c52a17828116bdc5a6e8',
    messagingSenderId: '259308116793',
    projectId: 'password-manager-7fbaa',
    storageBucket: 'password-manager-7fbaa.appspot.com',
    iosBundleId: 'com.example.passwordManager',
  );
}