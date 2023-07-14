import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:youtube_txt/top.dart';
import 'package:youtube_txt/urls.dart';
import 'package:http/http.dart' as http;

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  void initState() {
    super.initState();
  }

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

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = "", _password = "", type = "login";
  User? user;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginEmailFromui = TextEditingController();
    final loginPasswordFromui = TextEditingController();
    String errorText = "";

    return Column(children: [
      Container(
        alignment: Alignment.centerLeft,
        child: const Text('Login',
            style: TextStyle(fontSize: 30, color: Colors.black)),
      ),
      const SizedBox(height: 20),
      TextField(
        controller: loginEmailFromui,
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
      // 失敗したらエラーを表示
      if (errorText.isNotEmpty)
        Text(
          errorText,
          style: const TextStyle(color: Colors.red),
        ),
      SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {
                _email = loginEmailFromui.text;
                _password = loginPasswordFromui.text;
                _login(errorText); //loginのための関数
              },
              child: const Text('Login')))
    ]);
  }

  Future<void> _login(String errorText) async {
    try {
      final User? user =
          (await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      ))
              .user;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${user!.email} signed in'),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TopPage()),
      );
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        // const SnackBar(
        //   content: Text('Failed to sign in with Email & Password'),
        // ),
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _email = "", _password = "", _passwordAgain = "", type = "login";
  User? user;

  @override
  Widget build(BuildContext context) {
    final signupEmailFromui = TextEditingController();
    final signupPasswordFromui = TextEditingController();
    final signupPasswordAgainFromui = TextEditingController();
    String _errorText = '';

    return Column(children: [
      Container(
        alignment: Alignment.centerLeft,
        child: const Text('Sign Up',
            style: TextStyle(fontSize: 30, color: Colors.black)),
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
          decoration: const InputDecoration(labelText: "パスワード："),
          obscureText: true),
      const SizedBox(height: 10),
      TextField(
          controller: signupPasswordAgainFromui,
          decoration: const InputDecoration(labelText: "パスワード（確認）："),
          obscureText: true),
      const SizedBox(height: 20),
      // 失敗したらエラーを表示
      if (_errorText.isNotEmpty)
        Text(
          _errorText,
          style: const TextStyle(color: Colors.red),
        ),
      SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {
                _email = signupEmailFromui.text;
                _password = signupPasswordFromui.text;
                _passwordAgain = signupPasswordAgainFromui.text;
                // パスワードが同じか確認
                if (_password == _passwordAgain) {
                  _signup(); //signupのための関数
                } else {
                  setState(() {
                    _errorText = 'パスワードが一致しません';
                  });
                }
              },
              child: const Text('Sign Up')))
    ]);
  }

  Future<void> _signup() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${user!.email} signed in'),
        ),
      );
      // _emailをDjangoに送信する
      final _ = await http.post(
        SignUpUri(),
        body: {'email': _email},
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TopPage()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
