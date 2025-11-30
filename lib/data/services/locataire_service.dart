import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mbaaza_pay/data/models/locataire.dart';
import '../models/api_response.dart';
import 'api_service.dart';

class LocataireService {
  final ApiService _api = ApiService();
  final _storage = const FlutterSecureStorage();

  Future<String?> _getToken() => _storage.read(key: 'token');

  // ---------------------------------------------------------
  // 🔹 Liste des locataires
  // ---------------------------------------------------------
  Future<List<Locataire>> getLocataires() async {
    final token = await _getToken();
    final response = await _api.get("bailleurs/tenants", token: token);

    // Ici response.data doit contenir la liste de locataires
    final List<dynamic> data = json.decode(response.body);
    // On convertit chaque élément JSON en objet Locataire
    return data.map((json) => Locataire.fromJson(json)).toList();
  }
  
  // ---------------------------------------------------------
  // 🔹 Détails d’un locataire
  // ---------------------------------------------------------
  Future<Locataire> getLocataire(int id) async {
    final token = await _getToken();
    final response = await _api.get("locataires/$id", token: token);
    return json.decode(response.body);
  }

  // ---------------------------------------------------------
  // 🔹 Création d’un locataire
  // ---------------------------------------------------------
  Future<ApiResponse> createLocataire(Map<String, dynamic> data) async {
    try {
      final token = await _getToken();
      debugPrint(data.toString());
      final response = await _api.post("locataires", data, token: token);
      return response;
    } catch (e) {
      return ApiResponse(message: e.toString(), data: null, success: false);
    }
  }

  // ---------------------------------------------------------
  // 🔹 Modification d’un locataire
  // ---------------------------------------------------------
  Future<ApiResponse> updateLocataire(int id, Map<String, dynamic> data) async {
    try {
      final token = await _getToken();
      return await _api.put("locataires/$id", data, token: token);
    } catch (e) {
      return ApiResponse(message: e.toString(), data: null, success: false);
    }
  }

  // ---------------------------------------------------------
  // 🔹 Archiver / Désarchiver un locataire
  // ---------------------------------------------------------
  Future<ApiResponse> archiveToggle(int id) async {
    try {
      final token = await _getToken();
      return await _api.put("locataires/$id/archive", {}, token: token);
    } catch (e) {
      return ApiResponse(message: e.toString(), data: null, success: false);
    }
  }
}
