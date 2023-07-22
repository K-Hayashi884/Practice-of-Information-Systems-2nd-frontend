import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  @override
  void initState() {
    super.initState();
    VideoNotifier videoNotifier = Provider.of<VideoNotifier>(context, listen: false);
    Requester().topRequester().then((value) {
      videoNotifier.set(value);
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
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(prefixIcon: Icon(Icons.search)),
              ),
            ),
            VideoList(
              videoNotifier.videoTiles
            )
          ],
        ),
      ),
    );
  }
}
