import 'package:flutter/material.dart';
import 'package:youtube_txt/widget/drawer_menu.dart';
import 'package:youtube_txt/widget/video_list.dart';

import 'model/video.dart';
import 'package:provider/provider.dart';
import 'package:youtube_txt/requester/requester.dart';

class LaterVideosPage extends StatefulWidget {
  const LaterVideosPage({super.key});

  @override
  State<LaterVideosPage> createState() => _LaterVideosPageState();
}

class _LaterVideosPageState extends State<LaterVideosPage> {

  @override
  void initState() {
    super.initState();
    VideoNotifier videoNotifier =
        Provider.of<VideoNotifier>(context, listen: false);
    _fetchDataFromEndpoint(); // 初期データの取得
  }

  Future<void> _fetchDataFromEndpoint() async {
    try {
      List<Video> videos =
          await Requester().laterGetRequester();
      VideoNotifier videoNotifier =
          Provider.of<VideoNotifier>(context, listen: false);
      videoNotifier.set(videos);
    } catch (error) {
      // エラーハンドリング
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text("データの取得に失敗しました。"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    VideoNotifier videoNotifier = Provider.of<VideoNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Youtube.txt"),
      ),
      endDrawer: const DrawerMenu(),
      body: SingleChildScrollView(
        child: VideoList(
            videoNotifier.laterVideoListTiles
        )
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
