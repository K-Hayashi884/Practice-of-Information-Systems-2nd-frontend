import 'package:flutter/material.dart';
import 'package:youtube_txt/widget/video_list.dart';
import 'package:youtube_txt/later_videos.dart';
import 'package:youtube_txt/requester/requester.dart';

class VideoNotifier extends ChangeNotifier {
  List<Video> _videos = [];

  List<VideoListTile> get videoTiles{
    List<VideoListTile> videoTiles = [];
    for(var video in _videos){
      videoTiles.add(VideoListTile(video));
    }
    return videoTiles;
  }

  List<LaterVideoListTile> get laterVideoListTiles{
    List<LaterVideoListTile> laterList = [];
    for(var video in _videos){
      laterList.add(LaterVideoListTile(video));
    }
    return laterList;
  }

  List<Video> get videos => _videos;

  void set(List<Video> videos) {
    _videos = videos;
    notifyListeners();
  }

  int getId(videoId){
    return _videos.indexWhere((element) => element.id == videoId);
  }

  void setIndex(videoId){
    int id = getId(videoId);
    if(id != -1){
      Requester().headlineRequester(videoId).then((value) {
        List<Map<String, String>> test = value;
        _videos[id].indices = test;
        notifyListeners();
        debugPrint("notify");
      }).onError((error, stackTrace) {
        debugPrint("getheadlineError");
      });
    }
  }

  void remove(videoId){
    int id =getId(videoId);
    if(id != -1){
      _videos.removeAt(id);
      notifyListeners();
    }
  }
}

class Video {
  Video(
      {required this.url,
      this.id = "",
      this.title = "",
      this.count = 0,
      this.imageUrl = "",
      this.indices = const [{"timestamp":"0:00","headline":"取得中..."}],
      this.comments});

  final String url;
  String id;
  int count;
  String title;
  String imageUrl;
  List<Map<String, String>>? indices;
  List<String>? comments;

  Video.fromJson(Map<String, dynamic> json)
      : url = "https://www.youtube.com/watch?v${json['video_id']}",
        id = json['video_id'],
        count = json['video_count'],
        imageUrl = json['video_thumbnail_url'],
        title = json['video_title'];
}

// class Video {
//   Video(
//       {required this.url,
//       this.count = 0,
//       this.title = "",
//       this.image,
//       this.indices,
//       this.comments});

//   final String url;
//   int count;
//   String title;
//   Image? image;
//   List<Map<String, String>>? indices;
//   List<String>? comments;
// }
