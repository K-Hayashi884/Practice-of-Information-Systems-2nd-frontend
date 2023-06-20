import 'package:flutter/material.dart';

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
              VideoListTile(
                  Image.asset("images/dummy_thumbnail.png"), "おすすめ動画１"),
              VideoListTile(
                  Image.asset("images/dummy_thumbnail.png"), "おすすめ動画２"),
              VideoListTile(
                  Image.asset("images/dummy_thumbnail.png"), "おすすめ動画３"),
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

class VideoListTile extends StatelessWidget {
  final Image image;
  final String title;

  const VideoListTile(this.image, this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(height: 120, child: image),
      title: Text(title),
    );
  }
}
