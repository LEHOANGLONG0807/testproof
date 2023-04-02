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
    apiKey: 'AIzaSyAIgXbmWaqBjaj73L-XTZtifm9io5Oa3b8',
    appId: '1:525916450873:web:8dbf7ba6d7f7230a499de8',
    messagingSenderId: '525916450873',
    projectId: 'demoproof',
    authDomain: 'demoproof.firebaseapp.com',
    storageBucket: 'demoproof.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDZVT3uW0GfjGqNw6XHhC5qpun7LOQneBE',
    appId: '1:525916450873:android:f9bb74b9264de72a499de8',
    messagingSenderId: '525916450873',
    projectId: 'demoproof',
    storageBucket: 'demoproof.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAqupsVwdBUJeuvZiO7Gz19FvzM1Xd4qok',
    appId: '1:525916450873:ios:450af26ba7e7d3da499de8',
    messagingSenderId: '525916450873',
    projectId: 'demoproof',
    storageBucket: 'demoproof.appspot.com',
    iosClientId: '525916450873-kn1839nfc2lfjfa92te104jn96sbndgm.apps.googleusercontent.com',
    iosBundleId: 'com.example.demoproof',
  );
}