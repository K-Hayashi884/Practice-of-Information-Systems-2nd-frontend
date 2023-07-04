import 'package:flutter/material.dart';
import 'package:youtube_txt/model/video.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    final video = ModalRoute.of(context)!.settings.arguments as Video;
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    final List<Widget> thumbnailItems = [
      Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: SizedBox(
            width: deviceWidth * 0.8,
            child: Center(
                child: video.image != null
                    ? video.image!
                    : Image.asset("images/dummy_thumbnail.png"))),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: SizedBox(
          width: deviceWidth * 0.8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(video.title),
              OutlinedButton(onPressed: () {}, child: const Text("あとで見る")),
            ],
          ),
        ),
      ),
    ];
    final List<Widget> indicesList = [];
    if (video.indices != null) {
      for (Map<String, String> indice in video.indices!) {
        indicesList.add(Row(children: [
          SizedBox(
            width: deviceWidth * 0.3,
            child: TextButton(
              onPressed: () {},
              child: Text(indice["timestamp"]!),
            ),
          ),
          SizedBox(
            width: deviceWidth * 0.6,
            child: Text(indice["headline"]!),
          )
        ]));
      }
    }
    final List<Widget> commentsList = [];
    if (video.comments != null) {
      commentsList.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: SizedBox(
              width: deviceWidth * 0.85, child: const Text("コメントからのおすすめ")),
        ),
      );
      for (String comment in video.comments!) {
        commentsList.add(SizedBox(
          width: deviceWidth * 0.9,
          child: Text(
            comment,
            textAlign: TextAlign.start,
          ),
        ));
      }
    }
    return Scaffold(
      appBar: AppBar(title: const Text("Youtube.txt")),
      body: CustomScrollView(
        slivers: [
          SliverList(delegate: SliverChildListDelegate(thumbnailItems)),
          SliverList(delegate: SliverChildListDelegate(indicesList)),
          SliverList(delegate: SliverChildListDelegate(commentsList))
        ],
      ),
    );
  }
}
