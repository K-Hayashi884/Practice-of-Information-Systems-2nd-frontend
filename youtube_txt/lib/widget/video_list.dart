import 'package:flutter/material.dart';
import 'package:youtube_txt/model/video.dart';

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
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}

class VideoListTile extends StatelessWidget {
  final Video _video;

  const VideoListTile(this._video, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(height: 120, child: _video.image),
      title: Text(_video.title),
      onTap: () {
        Navigator.pushNamed(context, "index", arguments: _video);
      },
    );
  }
}
