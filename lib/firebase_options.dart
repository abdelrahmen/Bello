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
    apiKey: 'AIzaSyBw-jhlgXBtW0y27F80zSV6WbuvALN801E',
    appId: '1:547355892491:web:2ceab46c5b3321557a600e',
    messagingSenderId: '547355892491',
    projectId: 'bello-6823d',
    authDomain: 'bello-6823d.firebaseapp.com',
    storageBucket: 'bello-6823d.appspot.com',
    measurementId: 'G-FHJN8E6JBY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCzHK2_eobC439N2NKLGJsCVuqsHH21uUA',
    appId: '1:547355892491:android:3f4e4cdeeb5b6a627a600e',
    messagingSenderId: '547355892491',
    projectId: 'bello-6823d',
    storageBucket: 'bello-6823d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCoilfg0DJCWucWKic8qh-PcGT_hxepQog',
    appId: '1:547355892491:ios:2fa7c4afce1a93857a600e',
    messagingSenderId: '547355892491',
    projectId: 'bello-6823d',
    storageBucket: 'bello-6823d.appspot.com',
    iosClientId: '547355892491-ds3ehlrp8rv0jpbeus050kmhp0ilu5of.apps.googleusercontent.com',
    iosBundleId: 'com.example.bello',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCoilfg0DJCWucWKic8qh-PcGT_hxepQog',
    appId: '1:547355892491:ios:2fa7c4afce1a93857a600e',
    messagingSenderId: '547355892491',
    projectId: 'bello-6823d',
    storageBucket: 'bello-6823d.appspot.com',
    iosClientId: '547355892491-ds3ehlrp8rv0jpbeus050kmhp0ilu5of.apps.googleusercontent.com',
    iosBundleId: 'com.example.bello',
  );
}
