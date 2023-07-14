import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_txt/auth_provider.dart';

import 'package:youtube_txt/Userpage.dart';
import 'package:youtube_txt/top.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeArea Sample',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      routes: {
        '/top': (context) => const TopPage(),
        // 'index': (context) => const IndexPage(),
        "/": (context) => const UserPage(),
      },
    );
  }
}
