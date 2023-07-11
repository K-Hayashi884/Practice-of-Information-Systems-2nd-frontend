import 'package:http/http.dart' as http;

// class Url {
// https://stackoverflow.com/questions/55785581/socketexception-os-error-connection-refused-errno-111-in-flutter-using-djan
const String baseUrl = 'http://10.0.2.2:8000';

Uri signInUri() {
  return Uri.parse('$baseUrl/sign_in/');
}

Uri SignUpUri() {
  return Uri.parse('$baseUrl/sign_up/');
}

Uri SignOutUri() {
  return Uri.parse('$baseUrl/sign_out/');
}

Uri TopUri() {
  return Uri.parse('$baseUrl/top/');
}

Uri IndexUri(String video_id) {
  return Uri.parse('$baseUrl/index/$video_id/');
}

Uri LaterListUri(int user_id) {
  return Uri.parse('$baseUrl/list/$user_id/');
}

Uri AddLaterListUri(int user_id) {
  return Uri.parse('$baseUrl/list/$user_id/post/');
}

Uri DeleteLaterListUri(int user_id) {
  return Uri.parse('$baseUrl/list/$user_id/delete/');
}
// }
