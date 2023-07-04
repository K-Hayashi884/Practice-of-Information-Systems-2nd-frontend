import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
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
                SignupPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget{
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context){
    final loginUsernameFromui = TextEditingController();
    final loginPasswordFromui = TextEditingController();
    
     
     return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child:
            const Text(
              'Login',
               style: TextStyle(
                  fontSize: 30,
                  color: Colors.black
                )
              ),
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
          decoration: const InputDecoration(
            labelText: "パスワード："
            ),
          obscureText:true
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: (){
              String username = loginUsernameFromui.text;
              String password = loginPasswordFromui.text;
              print(username+password);//loginのための関数
            },
            child: const Text('Login')
          )
        )
      ]
    );
  }
}

class SignupPage extends StatelessWidget{
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context){
    final signupUsernameFromui = TextEditingController();
    final signupPasswordFromui = TextEditingController();
    final signupPasswordAgainFromui = TextEditingController();
     
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
        TextField(
          controller: signupUsernameFromui,
          decoration: const InputDecoration(
            labelText: "ユーザー名：",
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
            onPressed: (){
              String username = signupUsernameFromui.text;
              String password = signupPasswordFromui.text;
              String passwordAgain = signupPasswordAgainFromui.text;
              print(username+password);//signupのための関数
            },
            child: const Text('Sign Up')
          )
        )
      ]
    );
  }
}