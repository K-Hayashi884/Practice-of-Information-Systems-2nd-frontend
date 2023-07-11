import 'package:flutter/material.dart';
import 'package:youtube_txt/widget/video_list.dart';

import 'model/video.dart';

class TopPage extends StatelessWidget {
  const TopPage({super.key});

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
            VideoList([
              VideoListTile(Video(
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
                  "WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW"
                ],
              )),
              VideoListTile(Video(
                url: "www.google.com",
                title: "おすすめ動画２",
                image: Image.asset("images/dummy_thumbnail.png"),
              )),
              VideoListTile(Video(
                url: "www.google.com",
                title: "おすすめ動画３",
                image: Image.asset("images/dummy_thumbnail.png"),
              )),
            ])
          ],
        ),
      ),
    );
  }
}
