import 'package:flutter/material.dart';
import 'package:mansi_beauty_store/HomeScreen/HomePage.dart';
import 'package:mansi_beauty_store/MaterialScreens/Add_products.dart';
import 'package:mansi_beauty_store/Modules/Products.dart';
import 'package:mansi_beauty_store/Others/SplashScreen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
      options: const FirebaseOptions(apiKey: "AIzaSyBZWshwqnfb26jG4u5nDd5KnUhRlp53czk",
        appId: "1:762782794090:android:1849116344f99c31a2e513",
        messagingSenderId: "762782794090",
        projectId: "beauty-store-app-90ca1",
        storageBucket: "beauty-store-app-90ca1.appspot.com",
      )
  );

  await Firebase.initializeApp();
  //final FirebaseStorage storage = FirebaseStorage.instance;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}

