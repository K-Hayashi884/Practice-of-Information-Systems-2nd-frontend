import 'package:flutter/material.dart';

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
