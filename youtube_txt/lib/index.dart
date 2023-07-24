import 'package:flutter/material.dart';
import 'package:youtube_txt/model/video.dart';
import 'package:youtube_txt/requester/requester.dart';
import 'package:youtube_txt/widget/drawer_menu.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: true,
        mute: false,
        showFullscreenButton: false,
        loop: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("build index");
    VideoNotifier videoNotifier = Provider.of<VideoNotifier>(context);
    final videoRoute = ModalRoute.of(context)!.settings.arguments as Video;
    final deviceWidth = MediaQuery.of(context).size.width;
    var video = videoRoute;
    if (videoNotifier.getId(videoRoute.id) != -1) {
      video = videoNotifier.videos[videoNotifier.getId(videoRoute.id)];
    }
    debugPrint(video.indices.toString());

    _controller.cueVideoById(videoId: videoRoute.id);

    // final _controller = YoutubePlayerController(
    //   params: YoutubePlayerParams(
    //     mute: false,
    //     showControls: true,
    //     showFullscreenButton: false,
    //   ),
    // );

    // final _controller = YoutubePlayerController.fromVideoId(
    //   videoId: videoRoute.id,
    //   autoPlay: false,
    //   params: const YoutubePlayerParams(showFullscreenButton: true),
    // );

    double parseHHMMSS(String time) {
      List<String> parts = time.split(':');
      int hours = 0;
      int minutes;
      int seconds;

      if (parts.length == 3) {
        // HH:MM:SS 形式の場合
        hours = int.parse(parts[0]);
        minutes = int.parse(parts[1]);
        seconds = int.parse(parts[2]);
      } else if (parts.length == 2) {
        // MM:SS 形式の場合
        minutes = int.parse(parts[0]);
        seconds = int.parse(parts[1]);
      } else {
        throw const FormatException(
            "Invalid time format. Supported formats: HH:MM:SS or MM:SS");
      }

      return (hours * 3600 + minutes * 60 + seconds).toDouble();
    }

    final List<Widget> thumbnailItems = [
      Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: SizedBox(
            width: deviceWidth * 0.8,
            child: Center(
                child: YoutubePlayer(
              controller: _controller,
              aspectRatio: 16 / 9,
            )
                // child: video.imageUrl != null
                //     ? SizedBox(width: deviceWidth * 0.9, child: Image.network(video.imageUrl))
                //     : Image.asset("images/dummy_thumbnail.png")
                )),
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
              OutlinedButton(
                  onPressed: () {
                    Requester().laterAddRequester(videoRoute.id).then((_) {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: const Text("追加しました"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    }).onError((error, stackTrace) {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: Text(error.toString()),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    });
                  },
                  child: const Text("あとで見る")),
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
              onPressed: () {
                String? timestamp = indice["timestamp"];
                double timeFloat = timestamp != null
                    ? parseHHMMSS(timestamp)
                    : 0; // Set a default time of 0 seconds if timestamp is null
                _controller.seekTo(seconds: timeFloat, allowSeekAhead: true);
                var playerState = _controller.playerState;
                debugPrint(playerState.hashCode.toString());
              },
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
