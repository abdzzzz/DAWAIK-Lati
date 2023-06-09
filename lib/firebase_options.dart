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
        return macos;
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
    apiKey: 'AIzaSyDWC5aHX6AQVQSkM-wm10fA6EIMLY11fqY',
    appId: '1:306313957592:web:aebd7c30c8d0b0619607ad',
    messagingSenderId: '306313957592',
    projectId: 'prts-635dc',
    authDomain: 'prts-635dc.firebaseapp.com',
    storageBucket: 'prts-635dc.appspot.com',
    measurementId: 'G-8ZFM7XG70W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAvMTIMBCzLhIPddGd_tgJdjrVJWK7Y_1U',
    appId: '1:306313957592:android:30d2f3d830db4e6c9607ad',
    messagingSenderId: '306313957592',
    projectId: 'prts-635dc',
    storageBucket: 'prts-635dc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA6GbzXc16HKzczSgRAZgx8SQoyA3lyCws',
    appId: '1:306313957592:ios:2a27692c656fd36d9607ad',
    messagingSenderId: '306313957592',
    projectId: 'prts-635dc',
    storageBucket: 'prts-635dc.appspot.com',
    iosClientId: '306313957592-fdr6j96q62gj2vlj2uvsjtckla4fiui9.apps.googleusercontent.com',
    iosBundleId: 'com.example.prTest1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA6GbzXc16HKzczSgRAZgx8SQoyA3lyCws',
    appId: '1:306313957592:ios:2a27692c656fd36d9607ad',
    messagingSenderId: '306313957592',
    projectId: 'prts-635dc',
    storageBucket: 'prts-635dc.appspot.com',
    iosClientId: '306313957592-fdr6j96q62gj2vlj2uvsjtckla4fiui9.apps.googleusercontent.com',
    iosBundleId: 'com.example.prTest1',
  );
}
