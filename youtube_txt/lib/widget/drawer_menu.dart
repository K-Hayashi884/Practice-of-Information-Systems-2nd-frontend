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
                Navigator.of(context).pushNamedAndRemoveUntil("top", (_) => false);
              },
            ),
          ),
          ListTile(
            title: TextButton(
              child: const Text("あとで見る"),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil("later", (_) => false);
              },
            ),
          ),
          ListTile(
            title: TextButton(
              child: const Text("ログアウト"),
              onPressed: () {
                showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: const Text('Do you want logout?'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('No'),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                        ),
                        TextButton(
                          child: const Text('Yes'),
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
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
