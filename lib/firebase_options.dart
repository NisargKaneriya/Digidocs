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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
              'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyD0h61NjgS8pZgH8zk94-1QbEl4eA_XSNw',
    appId: '1:446173108382:web:b2a3be60609b581d72c38f',
    messagingSenderId: '446173108382',
    projectId: 'digidocs-cf08e',
    authDomain: 'digidocs-cf08e.firebaseapp.com',
    storageBucket: 'digidocs-cf08e.firebasestorage.app',
    measurementId: 'G-0DJREDY23Y',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD6JP6bfiZ1TKMjMJvTIjKW43qFbNzLnSI',
    appId: '1:446173108382:android:31e07253f2ead3e972c38f',
    messagingSenderId: '446173108382',
    projectId: 'digidocs-cf08e',
    storageBucket: 'digidocs-cf08e.firebasestorage.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCpmpfcH71zBhuSLS9tloZWKj2IGMtNE_M',
    appId: '1:446173108382:ios:602f1ca54462932872c38f',
    messagingSenderId: '446173108382',
    projectId: 'digidocs-cf08e',
    storageBucket: 'digidocs-cf08e.firebasestorage.app',
    iosBundleId: 'com.example.digidocs',
  );
}