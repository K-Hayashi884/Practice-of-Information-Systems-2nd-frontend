import 'package:flutter/material.dart';
import 'package:youtube_txt/requester/requester.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: TextButton(
              child: const Text("トップ"),
              onPressed: () {
                Navigator.pushReplacementNamed(context, "top");
              },
            ),
          ),
          ListTile(
            title: TextButton(
              child: const Text("あとで見る"),
              onPressed: () {
                Navigator.pushReplacementNamed(context, "later");
              },
            ),
          ),
          ListTile(
            title: TextButton(
              child: const Text("ログアウト"),
              onPressed: () {
                Requester()
                  .logoutRequester()
                  .then((_) {
                    Navigator.pushNamedAndRemoveUntil(context, "loginTop",(_) => false);
                  }).onError((error, stackTrace){ 
                    debugPrint(error.toString());
                  });
              },
            ),
          ),
        ],
      ),
    );
  }
}
