import 'package:flutter/foundation.dart';

// class Url {
// https://stackoverflow.com/questions/55785581/socketexception-os-error-connection-refused-errno-111-in-flutter-using-djan
//const String baseUrl = 'http://10.0.2.2:8000';

// String baseUri = defaultTargetPlatform == TargetPlatform.android
//       ? 'http://10.0.2.2:8000'
//       : 'http://127.0.0.1:8000';
String baseUri = "http://yu0ki.pythonanywhere.com/";

Uri signInUri() {
  return Uri.parse('$baseUri/api-token-auth/');
}

Uri signUpUri() {
  return Uri.parse('$baseUri/api/v1/register/');
}

Uri signOutUri() {
  return Uri.parse('$baseUri/sign_out/');
}

Uri topUri() {
  return Uri.parse('$baseUri/top/');
}

Uri indexUri(String video_id) {
  return Uri.parse('$baseUri/index/$video_id/');
}

Uri laterListUri(int user_id) {
  return Uri.parse('$baseUri/list/$user_id/');
}

Uri addLaterListUri(int user_id) {
  return Uri.parse('$baseUri/list/$user_id/post/');
}

Uri deleteLaterListUri(int user_id) {
  return Uri.parse('$baseUri/list/$user_id/delete/');
}
// }