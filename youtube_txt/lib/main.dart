import 'package:flutter/material.dart';
import 'package:youtube_txt/index.dart';
import 'package:youtube_txt/later_videos.dart';
import 'package:youtube_txt/top.dart';
import 'package:youtube_txt/login.dart';
import 'package:youtube_txt/signup.dart';
import 'package:youtube_txt/login_top.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeArea Sample',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      initialRoute: "loginTop",
      routes: {
        'top': (context) => const TopPage(),
        'index': (context) => const IndexPage(),
        'later': (context) => const LaterVideosPage(),
        'loginTop': (context) => const LoginTopPage(),
        'login': (context) => const LoginPage(),
        'signup': (context) => const SignUpPage(),
      },
    );
  }
}
