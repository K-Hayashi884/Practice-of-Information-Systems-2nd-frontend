import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_txt/urls.dart';
import 'Userpage.dart';
import 'package:youtube_txt/urls.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key});

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  String _text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Youtube.txt"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(prefixIcon: Icon(Icons.search)),
                // onChanged: (value) {
                //   setState(() {
                //     _text = value;
                //   });
                // },
              ),
            ),
            FutureBuilder<void>(
              future: _checkLoginAndMakeRequest(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // ログインチェックとリクエストが完了するまでローディング表示
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  // エラーハンドリング
                  return Text('Error: ${snapshot.error}');
                } else {
                  // リクエストが成功した場合の表示
                  return VideoList([
                    VideoListTile(
                        Image.asset("images/dummy_thumbnail.png"), "おすすめ動画１"),
                    VideoListTile(
                        Image.asset("images/dummy_thumbnail.png"), "おすすめ動画２"),
                    VideoListTile(
                        Image.asset("images/dummy_thumbnail.png"), "おすすめ動画３"),
                  ]);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _checkLoginAndMakeRequest(BuildContext context) async {
    // ログイン済みかどうかチェック
    String _idToken = "";
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      // ログインしている場合
      _idToken = await currentUser.getIdToken();
      print("_idToken: " + _idToken);
      http.Response response = await http.get(
        TopUri(),
        headers: {'Authorization': 'Bearer $_idToken'},
      );

      if (response.statusCode == 200) {
        // リクエスト成功の処理
        print(response.body);
      } else {
        // リクエスト失敗の処理
        print(response.body);
        throw Exception('Request failed with status ${response.statusCode}' +
            response.body);
      }
    } else {
      // ログインしていない場合
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UserPage()),
      );
      // throw Exception('User is not logged in');
    }
  }
}

class VideoList extends StatelessWidget {
  final List<VideoListTile> videos;

  const VideoList(this.videos, {Key? key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 20.0),
      itemBuilder: (context, index) => Container(
        padding: const EdgeInsets.all(20.0),
        alignment: Alignment.centerLeft,
        child: videos[index],
      ),
      separatorBuilder: (context, index) {
        return const Divider(height: 0.5);
      },
      itemCount: videos.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}

class VideoListTile extends StatelessWidget {
  final Image image;
  final String title;

  const VideoListTile(this.image, this.title, {Key? key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(height: 120, child: image),
      title: Text(title),
    );
  }
}
