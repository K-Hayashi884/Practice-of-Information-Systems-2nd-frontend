import 'package:flutter/material.dart';

class LoginTopPage extends StatelessWidget {
  const LoginTopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LOGIN TOP"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, "login");
                },
                icon: const Icon(Icons.login),
                label: const Text('Login')
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, "signup");
                },
                icon: const Icon(Icons.person_add),
                label: const Text('Sign up')
              ),
            ),
          ]
        ),
      )
    );
  }
}
