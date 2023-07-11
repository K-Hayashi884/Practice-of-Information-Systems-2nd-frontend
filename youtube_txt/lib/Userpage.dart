import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_txt/urls.dart';
import 'auth_service.dart';
import 'auth_provider.dart';
import 'package:youtube_txt/top.dart';

// const storage = FlutterSecureStorage();

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Youtube.txt'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Login'),
                Tab(text: 'SignUp'),
              ],
            ),
          ),
          body: const Padding(
            padding: EdgeInsets.symmetric(vertical: 120, horizontal: 50),
            child: TabBarView(
              children: [
                LoginPage(),
                SignupPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginUsernameFromui = TextEditingController();
    final loginPasswordFromui = TextEditingController();

    final AuthService _authService = AuthService();

    void _login(BuildContext context) async {
      try {
        // トークンを取得・保存
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        final token = await _authService.login(
          loginUsernameFromui.text,
          loginPasswordFromui.text,
          context,
        );
        authProvider.setToken(token);
      } catch (e) {
        print(e);
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: Text('Login Failed'),
              content: Text('Invalid username or password.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.of(dialogContext).pop(),
                ),
              ],
            );
          },
        );
      }
    }

    return Column(children: [
      Container(
        alignment: Alignment.centerLeft,
        child: const Text('Login',
            style: TextStyle(fontSize: 30, color: Colors.black)),
      ),
      const SizedBox(height: 20),
      TextField(
        controller: loginUsernameFromui,
        decoration: const InputDecoration(
          labelText: "ユーザー名：",
        ),
      ),
      const SizedBox(height: 10),
      TextField(
          controller: loginPasswordFromui,
          decoration: const InputDecoration(labelText: "パスワード："),
          obscureText: true),
      const SizedBox(height: 20),
      SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {
                _login(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TopPage()),
                );
              },
              child: const Text('Login')))
    ]);
  }
}

// Future<void> login(String username, String password) async {
//   var url = Uri.parse('http:/localhost/api/login/'); //ログインエンドポイントのURLを入れる
//   var headers = {
//     "Content-Type": "application/json",
//     "Authorization": "Bearer YOUR_ACCESS_TOKEN"
//   };
//   var body = json.encode({"username": username, "password": password});

//   var response = await http.post(url, headers: headers, body: body);

//   if (response.statusCode == 200) {
//     // ログイン成功時の処理
//     var responseData = json.decode(response.body);
//     await storage.write(
//         key: "accessToken",
//         value: responseData['access_token']); //あとでログイン時に参照できるようにする？？
//   } else {
//     // ログインエラー時の処理
//     throw Exception('ログインエラー');
//   }
// }

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final signupUsernameFromui = TextEditingController();
    final signupPasswordFromui = TextEditingController();
    final signupPasswordAgainFromui = TextEditingController();

    return Column(children: [
      Container(
        alignment: Alignment.centerLeft,
        child: const Text('Sign Up',
            style: TextStyle(fontSize: 30, color: Colors.black)),
      ),
      const SizedBox(height: 20),
      TextField(
        controller: signupUsernameFromui,
        decoration: const InputDecoration(
          labelText: "ユーザー名：",
        ),
      ),
      const SizedBox(height: 10),
      TextField(
          controller: signupPasswordFromui,
          decoration: const InputDecoration(labelText: "パスワード："),
          obscureText: true),
      const SizedBox(height: 10),
      TextField(
          controller: signupPasswordAgainFromui,
          decoration: const InputDecoration(labelText: "パスワード（確認）："),
          obscureText: true),
      const SizedBox(height: 20),
      SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {
                String username = signupUsernameFromui.text;
                String password = signupPasswordFromui.text;
                String passwordAgain = signupPasswordAgainFromui.text;
                signup(username, password, passwordAgain); //signupのための関数
              },
              child: const Text('Sign Up')))
    ]);
  }
}

Future<void> signup(
    String username, String password, String passwordAgain) async {
  if (password == passwordAgain) {
    var url = Uri.parse('http:/localhost/api/login/'); //ログインエンドポイントのURLを入れる
    var headers = {"Content-Type": "application/json"};
    var body = json.encode({"username": username, "password": password});

    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {
      // ログイン成功時の処理
      var responseData = json.decode(response.body);
      // await storage.write(
      //     key: "accessToken",
      //     value: responseData['access_token']); //あとでログイン時に参照できるようにする？？
    } else {
      // ログインエラー時の処理
      throw Exception('ログインエラー');
    }
  } else {
    throw Exception('パスワードが一致しません');
  }
}
