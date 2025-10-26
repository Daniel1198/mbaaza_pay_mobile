import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'api.dart';

class Auth {
  final Api _api = Api();
  final _storage = const FlutterSecureStorage();

  Future<dynamic> login(String telephone, String password) async {
    final response = await _api.post('bailleurs/signin', {
      'telephone': telephone,
      'password': password,
    });
    final data = jsonDecode(response.body);
    if (data['status'] == 200) {
      await _storage.write(key: 'token', value: data['data']);
    }
    return data;
  }

  Future<void> logout() async {
    final token = await _storage.read(key: 'token');
    await _api.post('/bailleurs/logout', {}, token: token);
    await _storage.delete(key: 'token');
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }
}
