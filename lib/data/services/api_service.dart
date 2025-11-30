import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/api_response.dart';

class ApiService {
  final String baseUrl = "http://192.168.1.8:8000/api/";

  Future<http.Response> get(String url, {String? token}) async {
    final headers = {
      "Accept": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };

    final response = await http.get(
      Uri.parse(baseUrl + url),
      headers: headers,
    );

    return response;
  }

  Future<ApiResponse> post(String url, Map<String, dynamic> body, {String? token}) async {
    final headers = {
      "Accept": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };

    final response = await http.post(
      Uri.parse(baseUrl + url),
      headers: headers,
      body: body,
    );

    return _handleResponse(response);
  }

  Future<ApiResponse> put(String url, Map<String, dynamic> body, {String? token}) async {
    final headers = {
      "Accept": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };

    final response = await http.put(
      Uri.parse(baseUrl + url),
      headers: headers,
      body: body,
    );

    return _handleResponse(response);
  }

  Future<ApiResponse> patch(String url, Map<String, dynamic> body, {String? token}) async {
    final headers = {
      "Accept": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };

    final response = await http.patch(
      Uri.parse(baseUrl + url),
      headers: headers,
      body: body,
    );

    return _handleResponse(response);
  }

  ApiResponse _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      // Succès
      return ApiResponse.fromJson(json.decode(response.body));
    } else {
      // Erreur Laravel abort
      final body = json.decode(response.body);

      throw Exception(body["message"] ?? "Erreur inconnue");
    }
  }
}
