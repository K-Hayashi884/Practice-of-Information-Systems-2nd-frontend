import 'package:flutter/material.dart';
import 'package:youtube_txt/widget/video_list.dart';
import 'package:youtube_txt/requester/requester.dart';

class VideoNotifier extends ChangeNotifier {
  List<Video> _videos = [];
  //int _frag = 0;

  List<VideoListTile> get videoTiles{
    List<VideoListTile> videoTiles = [];
    for(var video in _videos){
      videoTiles.add(VideoListTile(video));
    }
    return videoTiles;
  } 

  List<Video> get videos => _videos;

  void set(List<Video> videos) {
    //if(_frag == 0){
      _videos = videos;
      //_frag = 1;
      notifyListeners();
    //}
  }

  int getId(videoId){
    return _videos.indexWhere((element) => element.id == videoId);
  }

  // List<Map<String, String>> headline(videoId){
  //   List<Map<String, String>> test = [];
  //   Requester().headlineRequester(videoId).then((value) {
  //     List<Map<String, String>> test = value;
  //   }).onError((error, stackTrace) {
  //       debugPrint("getheadlineError");
  //   });
  //   return test;
  // }

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
}

class Video {
  Video(
      {required this.url,
      this.id = "",
      this.title = "",
      this.count = 0,
      this.imageUrl = "",
      this.indices,
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
