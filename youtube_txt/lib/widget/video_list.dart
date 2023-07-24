import 'package:flutter/material.dart';
import 'package:youtube_txt/model/video.dart';
import 'package:provider/provider.dart';

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
  final Video video;
  final Widget? trailing;
  const VideoListTile(this.video, {super.key, this.trailing});

  @override
  Widget build(BuildContext context) {

    Future<void> _setIndex() async {
      VideoNotifier videoNotifier = Provider.of<VideoNotifier>(context,listen: false);
      videoNotifier.setIndex(video.id);
    }

    VideoNotifier videoNotifier = Provider.of<VideoNotifier>(context);
    return ListTile(
      leading: SizedBox(height: 120, child: Image.network(video.imageUrl)),
      title: Text(
        video.title,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        debugPrint(video.indices.toString());
        if(video.indices == null){
           _setIndex();
          //videoNotifier.setIndex(video.id);
          debugPrint("complete set index");
        }
        Navigator.pushNamed(context, "index", arguments: video);
      },
      trailing: trailing,
    );
  }
}
