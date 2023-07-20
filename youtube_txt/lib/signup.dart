import 'package:flutter/material.dart';
import 'package:youtube_txt/requester/requester.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final signupUsernameFromui = TextEditingController();
  final signupEmailFromui = TextEditingController();
  final signupPasswordFromui = TextEditingController();
  final signupPasswordAgainFromui = TextEditingController();
  var _errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 120, right:50, left:50),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: const Text('Sign Up',
              style: TextStyle(
                fontSize: 30,
                color: Colors.black
                )
              ),
            ),
            const SizedBox(height: 12.0),
            Text(_errorMessage, style: const TextStyle(color: Colors.red)),
            TextField(
              controller: signupUsernameFromui,
              decoration: const InputDecoration(
                labelText: "ユーザー名：",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: signupEmailFromui,
              decoration: const InputDecoration(
                labelText: "メールアドレス：",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: signupPasswordFromui,
              decoration: const InputDecoration(labelText: "パスワード："),
              obscureText: true
            ),
            TextField(
              controller: signupPasswordAgainFromui,
              decoration: const InputDecoration(
                labelText: "パスワード（確認）："
              ),
              obscureText:true
            ),
            const SizedBox(height: 20),   
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if(signupPasswordFromui.text.isEmpty){
                    setState(() {
                      _errorMessage = "パスワードを入力してください";
                    });
                  }else if(signupPasswordFromui.text == signupPasswordAgainFromui.text){
                    debugPrint(signupPasswordFromui.text);
                    Requester().signUpRequester(signupUsernameFromui.text, signupEmailFromui.text, signupPasswordAgainFromui.text).then((_) {
                      setState(() {
                        _errorMessage = "";
                      });
                      Navigator.of(context).pushReplacementNamed("login");
                    }).onError((error, stachTrace) {
                      debugPrint(error.toString());
                      signupPasswordFromui.clear();
                      signupPasswordAgainFromui.clear();
                      setState(() {
                        _errorMessage = "ユーザーの作成に失敗しました。すでに登録済みのユーザーです";
                      });
                    });
                  }else{
                    setState(() {
                      _errorMessage = "パスワードが一致しません";
                    });
                  }
                },
                child: const Text('Sign Up')
              )
            )
          ],
        ),
      ),
    );
  }
}