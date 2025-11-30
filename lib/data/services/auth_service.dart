import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'api_service.dart';
import '../models/api_response.dart';

class Auth {
  final ApiService _api = ApiService();
  final _storage = const FlutterSecureStorage();

  // ------------------------------------------
  // LOGIN
  // ------------------------------------------
  Future<ApiResponse> login(String telephone, String password) async {
    try {
      final response = await _api.post('bailleurs/signin', {
        'telephone': telephone,
        'password': password,
      });

      // Si l'API retourne un token dans data
      if (response.data != null && response.data is String) {
        await _storage.write(key: 'token', value: response.data);
      }

      return response;
    } catch (e) {
      // _api.post() lance déjà Exception(message)
      return ApiResponse(message: e.toString(), data: null, success: false);
    }
  }

  // ------------------------------------------
  // LOGOUT
  // ------------------------------------------
  Future<ApiResponse> logout() async {
    try {
      final token = await _storage.read(key: 'token');
      final response = await _api.post('bailleurs/logout', {}, token: token);
      await _storage.delete(key: 'token');
      return response;
    } catch (e) {
      return ApiResponse(message: e.toString(), data: null, success: false);
    }
  }

  // ------------------------------------------
  // RÉCUPÉRER LE TOKEN
  // ------------------------------------------
  Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }

  // ------------------------------------------
  // RÉCUPÉRER USER À PARTIR DU TOKEN
  // ------------------------------------------
  Future<Map<String, dynamic>?> getUserFromToken() async {
    final token = await _storage.read(key: 'token');
    if (token == null) return null;

    if (JwtDecoder.isExpired(token)) return null;

    return JwtDecoder.decode(token);
  }

  Future<ApiResponse> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final token = await _storage.read(key: 'token');
    if (token == null) throw Exception("Token manquant");

    final response = await _api.put("bailleurs/password/change", {
      "currentPassword": currentPassword,
      "newPassword": newPassword,
    }, token: token);
    return response;
  }
}
