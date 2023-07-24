import 'package:flutter/material.dart';
import 'package:youtube_txt/widget/drawer_menu.dart';
import 'package:youtube_txt/widget/video_list.dart';

import 'model/video.dart';

class LaterVideosPage extends StatelessWidget {
  const LaterVideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Youtube.txt"),
      ),
      endDrawer: const DrawerMenu(),
      body: SingleChildScrollView(
        child: VideoList([
          LaterVideoListTile(Video(
            url: "www.google.com",
            title:
                "WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW",
            image: Image.asset("images/dummy_thumbnail.png"),
            indices: [
              {"timestamp": "0:20", "headline": "オープニング"},
              {"timestamp": "10:33", "headline": "議題１"},
            ],
            comments: [
              "12:34 ここ好き",
              "56:78 ここ好き",
              "WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW",
              "a",
              "b",
              "c",
              "d",
              "e"
            ],
          )),
          LaterVideoListTile(Video(
            url: "www.google.com",
            title: "おすすめ動画２",
            image: Image.asset("images/dummy_thumbnail.png"),
          )),
          LaterVideoListTile(Video(
            url: "www.google.com",
            title: "おすすめ動画３",
            image: Image.asset("images/dummy_thumbnail.png"),
          )),
        ]),
      ),
    );
  }
}

class LaterVideoListTile extends VideoListTile {
  LaterVideoListTile(super.video, {super.key});

  @override
  final Widget? trailing =
      IconButton(onPressed: () {}, icon: const Icon(Icons.delete));
}
