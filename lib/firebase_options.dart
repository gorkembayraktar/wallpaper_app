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
    apiKey: 'AIzaSyDdACs2LLCZ7vA3lEqlBgTD4bdrWUhU5Ls',
    appId: '1:701789396085:web:7ffe6be865d35e4e016c3c',
    messagingSenderId: '701789396085',
    projectId: 'vue-wallpaper-25d42',
    authDomain: 'vue-wallpaper-25d42.firebaseapp.com',
    storageBucket: 'vue-wallpaper-25d42.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAmnex6FCuZhkWvhKh0DGhiWwisuaQpDhw',
    appId: '1:701789396085:android:13ddf39a2c31c251016c3c',
    messagingSenderId: '701789396085',
    projectId: 'vue-wallpaper-25d42',
    storageBucket: 'vue-wallpaper-25d42.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDWg4W8ycGvBm3UTrkI9zrhiWEp0_SKdNw',
    appId: '1:701789396085:ios:5eaf3e8ce03f1f7b016c3c',
    messagingSenderId: '701789396085',
    projectId: 'vue-wallpaper-25d42',
    storageBucket: 'vue-wallpaper-25d42.appspot.com',
    iosBundleId: 'com.example.vueWp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDWg4W8ycGvBm3UTrkI9zrhiWEp0_SKdNw',
    appId: '1:701789396085:ios:c0afa8822861bb2c016c3c',
    messagingSenderId: '701789396085',
    projectId: 'vue-wallpaper-25d42',
    storageBucket: 'vue-wallpaper-25d42.appspot.com',
    iosBundleId: 'com.example.vueWp.RunnerTests',
  );
}
