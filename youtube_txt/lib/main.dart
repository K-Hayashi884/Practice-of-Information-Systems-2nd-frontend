import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_txt/auth_provider.dart';
import 'package:youtube_txt/index.dart';
import 'package:youtube_txt/top.dart';

import 'package:youtube_txt/Userpage.dart';

void main() {
  runApp(
    // MyAppの直下にProviderを配置
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        // 追加のプロバイダーがある場合はここに追加してください
      ],
      child: const MyApp(),
    ),
  );
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
        'index': (context) => const IndexPage(),
        "/": (context) => const UserPage(),
      },
    );
  }
}
