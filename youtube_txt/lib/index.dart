import 'package:flutter/material.dart';
import 'package:youtube_txt/model/video.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    final video = ModalRoute.of(context)!.settings.arguments as Video;
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: const Text("Youtube.txt")),
      body: Center(
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(children: [
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
                      OutlinedButton(
                          onPressed: () {}, child: const Text("あとで見る")),
                    ],
                  ),
                ),
              ),
              video.indices != null
                  ? SizedBox(
                      width: deviceWidth * 0.9,
                      height: deviceHeight * 0.3,
                      child: SingleChildScrollView(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: video.indices!.length,
                            itemBuilder: (context, index) {
                              return Row(children: [
                                SizedBox(
                                  width: deviceWidth * 0.3,
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                        video.indices![index]["timestamp"]!),
                                  ),
                                ),
                                SizedBox(
                                  width: deviceWidth * 0.6,
                                  child:
                                      Text(video.indices![index]["headline"]!),
                                )
                              ]);
                            }),
                      ),
                    )
                  : const SizedBox(),
              video.comments != null
                  ? Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: SizedBox(
                                width: deviceWidth * 0.85,
                                child: const Text("コメントからのおすすめ")),
                          ),
                          SizedBox(
                            width: deviceWidth * 0.9,
                            height: deviceHeight * 0.3,
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: video.comments!.length,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    width: deviceWidth * 0.9,
                                    child: Text(
                                      video.comments![index],
                                      textAlign: TextAlign.start,
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ]),
          ),
        ),
      ),
    );
  }
}
