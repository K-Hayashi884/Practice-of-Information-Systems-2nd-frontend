import 'package:flutter/material.dart';
import 'package:youtube_txt/widget/drawer_menu.dart';
import 'package:youtube_txt/widget/video_list.dart';
import 'package:youtube_txt/requester/requester.dart';

import 'model/video.dart';

class TopPage extends StatefulWidget {
  const TopPage({super.key});

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  List<VideoListTile> videos = [];

  @override
  void initState() {
    super.initState();

    Requester().topRequester().then((value) {
      setState(() {
        for(var video in value){
          videos.add(VideoListTile(video));
          debugPrint(video.title);
        }
        debugPrint(videos.toString());
      });
    }).onError((error, stackTrace) {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text("データの取得に失敗しました。"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context), child: const Text("OK")),
              ],
            );
          }).then((_) {
        Navigator.pop(context);
      });
    });

    // videos = Requester()
    //           .topRequester()
    //           .then((_) {
    //             setState(() {
    //             });
    //           })
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(videos.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Youtube.txt"),
      ),
      endDrawer: const DrawerMenu(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(prefixIcon: Icon(Icons.search)),
              ),
            ),
            VideoList(
              videos
            //   [
            //   VideoListTile(Video(
            //     url: "www.google.com",
            //     title:
            //          "WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW",
            //         //videos[1].title,
            //     image: Image.asset("images/dummy_thumbnail.png"),
            //     indices: [
            //       {"timestamp": "0:20", "headline": "オープニング"},
            //       {"timestamp": "10:33", "headline": "議題１"},
            //     ],
            //     comments: [
            //       "12:34 ここ好き",
            //       "56:78 ここ好き",
            //       "WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW",
            //       "a",
            //       "b",
            //       "c",
            //       "d",
            //       "e"
            //     ],
            //   )),
            //   VideoListTile(Video(
            //     url: "www.google.com",
            //     title: "おすすめ動画２",
            //     image: Image.asset("images/dummy_thumbnail.png"),
            //   )),
            //   VideoListTile(Video(
            //     url: "www.google.com",
            //     title: "おすすめ動画３",
            //     image: Image.asset("images/dummy_thumbnail.png"),
            //   )),
            // ]
            )
          ],
        ),
      ),
    );
  }
}
