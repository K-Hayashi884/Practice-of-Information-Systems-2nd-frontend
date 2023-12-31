import 'package:flutter/material.dart';
import 'package:youtube_txt/model/video.dart';
import 'package:youtube_txt/widget/drawer_menu.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    final video = ModalRoute.of(context)!.settings.arguments as Video;
    final deviceWidth = MediaQuery.of(context).size.width;

    final List<Widget> thumbnailItems = [
      Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: SizedBox(
            width: deviceWidth * 0.8,
            child: Center(
                child: video.image != null
                    ? SizedBox(width: deviceWidth * 0.9, child: video.image!)
                    : Image.asset("images/dummy_thumbnail.png"))),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: SizedBox(
          width: deviceWidth * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  width: deviceWidth * 0.4,
                  child: Text(
                    video.title,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  )),
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
            height: 35,
            child: TextButton(
              onPressed: () {},
              child: Text(indice["timestamp"]!),
            ),
          ),
          SizedBox(
            width: deviceWidth * 0.6,
            child: Text(
              indice["headline"]!,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ]));
      }
      indicesList.add(const SizedBox(
        height: 16,
      ));
    }

    final List<Widget> commentsList = [];
    if (video.comments != null) {
      commentsList.add(
        Container(
          width: deviceWidth,
          alignment: Alignment.center,
          child: Container(
              padding: const EdgeInsets.only(bottom: 12),
              width: deviceWidth * 0.9,
              child: const Text("コメントからのおすすめ")),
        ),
      );
      for (String comment in video.comments!) {
        commentsList.add(Container(
          padding: const EdgeInsets.only(bottom: 12),
          width: deviceWidth,
          alignment: Alignment.center,
          child: Flexible(
            child: SizedBox(
              width: deviceWidth * 0.8,
              child: Text(
                comment,
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ));
      }
      commentsList.add(const SizedBox(
        height: 12,
      ));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Youtube.txt")),
      endDrawer: const DrawerMenu(),
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
