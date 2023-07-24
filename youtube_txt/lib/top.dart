import 'package:flutter/material.dart';
import 'package:youtube_txt/widget/drawer_menu.dart';
import 'package:youtube_txt/widget/video_list.dart';

import 'model/video.dart';

class TopPage extends StatefulWidget {
  const TopPage({super.key});

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
                  "WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW",
                  "a",
                  "b",
                  "c",
                  "d",
                  "e"
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

class VideoList extends StatelessWidget {
  final List<VideoListTile> videos;

  const VideoList(this.videos, {super.key});

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
      physics: NeverScrollableScrollPhysics(),
    );
  }
}
