import 'package:flutter/material.dart';
import 'package:youtube_txt/requester/requester.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginUsernameFromui = TextEditingController();
  final loginPasswordFromui = TextEditingController();
  var _errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 120, right:50, left:50),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: const Text('Login',
              style: TextStyle(
                fontSize: 30,
                color: Colors.black
                )
              ),
            ),
            const SizedBox(height: 12.0),
            Text(_errorMessage, style: const TextStyle(color: Colors.red)),
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
              obscureText: true
            ),
            const SizedBox(height: 20),   
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Requester()
                  .loginRequester(loginUsernameFromui.text, loginPasswordFromui.text)
                  .then((_) {
                    setState(() {
                      _errorMessage = "";
                    });
                    Navigator.pushNamedAndRemoveUntil(context, "top",ModalRoute.withName("login_top"));
                  }).onError((error, stackTrace) {
                    debugPrint(error.toString());
                    loginPasswordFromui.clear();
                    setState(() {
                      _errorMessage = "ログインに失敗しました。ユーザー名かパスワードが間違っています。";
                    });
                  });
                },
                child: const Text('Login')
              )
            )
          ],
        ),
      ),
    );
  }
}