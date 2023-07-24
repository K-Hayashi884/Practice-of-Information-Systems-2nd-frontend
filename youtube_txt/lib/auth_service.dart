import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'auth_provider.dart';
import 'package:flutter/material.dart';
import 'urls.dart';

class AuthService {
  static const String apiUrl = '<http://your-django-api-url/api>';

  Future<String?> login(
      String username, String password, BuildContext context) async {
    final response = await http.post(
      signInUri(),
      body: {'username': username, 'password': password},
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final token = jsonResponse['token'];

      // トークンをAuthProviderに保存します
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.setToken(token);

      return token;
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<String> fetchProtectedPage(String path, String token) async {
    final response = await http.get(
      Uri.parse('$apiUrl/$path/'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to fetch protected page');
    }
  }
}
