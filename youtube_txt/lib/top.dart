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
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    VideoNotifier videoNotifier =
        Provider.of<VideoNotifier>(context, listen: false);
    _fetchDataFromEndpoint(); // 初期データの取得
  }

  // エンドポイントにアクセスしてデータを取得する非同期処理
  Future<void> _fetchDataFromEndpoint({String? searchQuery}) async {
    try {
      List<Video> videos =
          await Requester().topRequester(searchQuery: searchQuery);
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

  void _onSearchPressed() {
    String searchQuery = searchController.text;
    _fetchDataFromEndpoint(searchQuery: searchQuery); // 検索クエリを渡して再描画
  }

  void _onSearchSubmitted(String searchQuery) {
    _fetchDataFromEndpoint(searchQuery: searchQuery); // 検索クエリを渡して再描画
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
            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                controller: searchController,
                onSubmitted: _onSearchSubmitted,
                decoration: InputDecoration(
                  prefixIcon: InkWell(
                    onTap: _onSearchPressed, // 検索ボタンが押されたら再描画
                    child: const Icon(Icons.search),
                  ),
                ),
              ),
            ),
            VideoList(videoNotifier.videoTiles),
          ],
        ),
      ),
    );
  }
}
