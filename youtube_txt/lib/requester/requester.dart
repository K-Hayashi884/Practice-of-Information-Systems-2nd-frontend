import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:youtube_txt/requester/urls.dart';
import 'package:youtube_txt/model/video.dart';

class Requester {
  String uri = defaultTargetPlatform == TargetPlatform.android
      ? 'http://10.0.2.2:8000/'
      : 'http://127.0.0.1:8000/';

  Map<String, String> headers = {
    "Content-Type": "application/json",
  };
  final storage = const FlutterSecureStorage();

  Requester() {}

  Future<void> loginRequester(String name, String password) async {
    var request = AuthRequest(name: name, password: password);

    final response = await http.post(signInUri(),
        body: json.encode(request.toJson()), headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> decoded = json.decode(response.body);
      var loginResponse = AuthResponse.fromJson(decoded);
      debugPrint(loginResponse.accessToken);
      await storage.write(key: "accessToken", value: loginResponse.accessToken);
    } else {
      throw Exception("Login Error");
    }
  }

  Future<void> signUpRequester(
      String name, String email, String password) async {
    var request = RegisterRequest(
      name: name,
      email: email,
      password: password,
    );

    debugPrint(name);
    debugPrint(password);
    debugPrint(email);

    final response = await http.post(signUpUri(),
        body: json.encode(request.toJson()), headers: headers);

    debugPrint(response.statusCode.toString());

    if (response.statusCode == 201) {
      debugPrint("test success");
      Map<String, dynamic> decoded = json.decode(response.body);
      var signUpResponse = RegisterResponse.fromJson(decoded);
      debugPrint(signUpResponse.username);
    } else {
      debugPrint("test fail");
      throw Exception("Sign UP Error");
    }
  }

  Future<List<Video>> topRequester({String? searchQuery}) async {
    var accessToken = await storage.read(key: "accessToken");
    headers["Authorization"] = "Token $accessToken";

    debugPrint("send topRequester");

    Uri uri;
    if (searchQuery != null) {
      uri = topUri().replace(queryParameters: {"search_query": searchQuery});
    } else {
      uri = topUri();
    }

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final decoded = json
          .decode(utf8.decode(response.bodyBytes))
          .cast<Map<String, dynamic>>();
      List<Video> videoList =
          decoded.map<Video>((json) => Video.fromJson(json)).toList();
      return videoList;
    } else {
      throw Exception("Top Error");
    }
  }

  Future<List<Map<String, String>>> headlineRequester(videoId) async {
    var accessToken = await storage.read(key: "accessToken");
    headers["Authorization"] = "Token $accessToken";

    debugPrint("send headlineRequester");
    final response = await http.get(indexUri(videoId), headers: headers);

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> decoded = await json
          .decode(utf8.decode(response.bodyBytes))
          .cast<Map<String, dynamic>>();
      List<Map<String, String>> headlines = decoded
          .map<Map<String, String>>((json) => json.cast<String, String>())
          .toList();
      return headlines;
    } else {
      throw Exception("headline(index) Error");
    }
  }

  Future<String> helloRequester() async {
    var helloUri = uri + "api/v1/account/1/";
    var accessToken = await storage.read(key: "accessToken");
    headers["Authorization"] = "Token $accessToken";

    debugPrint("send helloRequester");
    final response = await http.get(Uri.parse(helloUri), headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> decoded = json.decode(response.body);
      var helloResponse = HelloResponse.fromJson(decoded);
      return helloResponse.message;
    } else {
      throw Exception("Hello Error");
    }
  }

  Future<void> logoutRequester() async {
    await storage.delete(key: "accessToken");
  }
}

class HelloResponse {
  final message;

  HelloResponse.fromJson(Map<String, dynamic> json)
      : message = json['username'];
}

class RegisterResponse {
  final int id;
  final String username;

  RegisterResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'];
}

class RegisterRequest {
  final String name;
  final String password;
  final String email;

  RegisterRequest({
    this.name = "",
    this.password = "",
    this.email = "",
  });

  Map<String, dynamic> toJson() => {
        'password': password,
        'username': name,
        'email': email,
      };
}

class AuthResponse {
  final String accessToken;

  AuthResponse.fromJson(Map<String, dynamic> json)
      : accessToken = json['token'];
}

class AuthRequest {
  final String name;
  final String password;

  AuthRequest({
    this.name = "",
    this.password = "",
  });

  Map<String, dynamic> toJson() => {
        'password': password,
        'username': name,
      };
}

class TopResponse {
  final String id;
  final String thumbnailUrl;
  final int count;
  final String title;

  TopResponse.fromJson(Map<String, dynamic> json)
      : id = json['video_id'],
        thumbnailUrl = json['video_thumbnail_url'],
        count = json['video_count'],
        title = json['video_title'];
}
