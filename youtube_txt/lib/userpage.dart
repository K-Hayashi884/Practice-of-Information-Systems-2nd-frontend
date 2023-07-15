import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_txt/requester/requester.dart';
import 'package:youtube_txt/top.dart';


const storage = FlutterSecureStorage();

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>{
  // @override
  // void initState(){
  //   super.initState();
  //   initialize();
  // }

  // Future<void> initialize() async{
  //   String? accessToken = await storage.read(key: "accessToken");
  //   if(accessToken != null){
  //     var url = Uri.parse('http:/localhost/api/login/');  //ログインエンドポイントのURLを入れる
  //     var headers = {
  //       "Content-Type": "application/json"};
  //     var body = json.encode({"access_token": accessToken});

  //     var response = await http.post(url, headers: headers, body: body);

  //     if (response.statusCode == 200) {
  //       // ログイン成功時の処理
  //       var responseData = json.decode(response.body);
  //       await storage.write(key: "accessToken", value: responseData['access_token']); 
  //       //Navigator.push(
  //       //  context,
  //       //  MaterialPageRoute(builder: (context) => HomePage()),
  //       //);
  //     } 
  //   }
  // }

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
                Tab(text:'Login'),
                Tab(text:'SignUp'),
              ],
            ),
          ),
          body: const Padding(
            padding: EdgeInsets.symmetric(vertical: 120, horizontal: 50),
            child: TabBarView(
              children:[
                LoginPage(),
                SignUpPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
    return Column(children: [
      Container(
        alignment: Alignment.centerLeft,
        child: const Text('Login',
            style: TextStyle(fontSize: 30, color: Colors.black)),
      ),
      const SizedBox(height: 12.0),
      Text(_errorMessage, style: const TextStyle(color: Colors.red)),
      TextField(
        controller: loginUsernameFromui,
        decoration: const InputDecoration(
          labelText: "メールアドレス：",
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
                Requester()
                    .loginRequester(loginUsernameFromui.text, loginPasswordFromui.text)
                    .then((_) {
                      setState(() {
                        _errorMessage = "";
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const TopPage()));
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
    ]);
  }
}

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

    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child:const Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 30,
              color: Colors.black
            )
          ),
        ), 
        const SizedBox(height: 20), 
        Text(_errorMessage, style: const TextStyle(color: Colors.red)),
        TextField(
          controller: signupUsernameFromui,
          decoration: const InputDecoration(
            labelText: "ユーザー名：",
          ),
        ),
        const SizedBox(height: 20), 
        TextField(
          controller: signupEmailFromui,
          decoration: const InputDecoration(
            labelText: "メールアドレス：",
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: signupPasswordFromui,
          decoration: const InputDecoration(
            labelText: "パスワード："
            ),
          obscureText:true
        ),
        const SizedBox(height: 10),
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
              Requester()
                .signUpRequester(signupUsernameFromui.text,signupEmailFromui.text, signupPasswordFromui.text)
                    .then((_) {
                      setState(() {
                        _errorMessage = "";
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const UserPage()));
                    }).onError((error, stackTrace) {
                      debugPrint(error.toString());
                      signupPasswordFromui.clear();
                      setState(() {
                        _errorMessage = "ユーザーの作成に失敗しました。すでに登録済みのユーザーです。";
                      });
                    });
              },
            child: const Text('Sign Up')
          )
        )
      ]
    );
  }
}