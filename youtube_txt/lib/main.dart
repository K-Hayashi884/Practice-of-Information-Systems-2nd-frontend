import 'package:flutter/material.dart';
import 'package:youtube_txt/index.dart';
import 'package:youtube_txt/later_videos.dart';
import 'package:youtube_txt/top.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeArea Sample',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      initialRoute: "top",
      routes: {
        'top': (context) => const TopPage(),
        'index': (context) => const IndexPage(),
        'later': (context) => const LaterVideosPage(),
        '/': (context) => TopPage(),
      },
    );
  }
}
