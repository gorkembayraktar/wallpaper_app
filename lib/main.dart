import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vue_wp/firebase_options.dart';
import 'package:vue_wp/screens/LandingPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vue Wallpaper',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'GoogleSans',
          useMaterial3: true,
          canvasColor: Colors.white,
          primaryIconTheme: IconThemeData(color: Colors.black)
      ),
      home: FutureBuilder(
        future:  Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return const Center(child: Text('Bir sorun oluştu, yeniden başlatın.'),);
          }
          if(snapshot.hasData){
            return const LandingPage();
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

