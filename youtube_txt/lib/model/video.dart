import 'package:flutter/material.dart';

class Video {
  Video(
      {required this.url,
      this.count = 0,
      this.title = "",
      this.image,
      this.indices,
      this.comments});

  final String url;
  int count;
  String title;
  Image? image;
  List<Map<String, String>>? indices;
  List<String>? comments;
}
