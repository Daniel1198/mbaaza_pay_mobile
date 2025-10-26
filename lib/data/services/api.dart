import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  final String baseUrl = 'http://192.168.1.11:8000/api'; // pour émulateur Android

  Future<http.Response> post(String endpoint, Map<String, dynamic> data, {String? token}) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
    return await http.post(url, headers: headers, body: jsonEncode(data));
  }

  Future<http.Response> get(String endpoint, {String? token}) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    final headers = {
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
    return await http.get(url, headers: headers);
  }
}
