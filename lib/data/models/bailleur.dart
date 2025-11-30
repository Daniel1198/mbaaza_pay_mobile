import 'package:mbaaza_pay/data/models/pays.dart';

import 'exercice.dart';

class Bailleur {
  final int id;
  final String code;
  final String nomComplet;
  final String? email;
  final String telephone;
  final String? whatsapp;
  final String? localisation;
  final String? photo;
  final int dateEcheanceParDefaut;
  final Exercice? exerciceEnCours;
  final Pays? paysResidence;
  final String? archivedAt;
  final String? createdAt;
  final String? updatedAt;

  Bailleur({
    required this.id,
    required this.code,
    required this.nomComplet,
    this.email,
    required this.telephone,
    this.whatsapp,
    required this.localisation,
    this.photo,
    required this.dateEcheanceParDefaut,
    this.exerciceEnCours,
    this.paysResidence,
    this.archivedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Bailleur.fromJson(Map<String, dynamic> json) {
    return Bailleur(
      id: json['id'],
      code: json['code'],
      nomComplet: json['nomComplet'],
      email: json['email'],
      telephone: json['telephone'],
      whatsapp: json['whatsapp'],
      localisation: json['localisation'],
      photo: json['photo'],
      dateEcheanceParDefaut: json['dateEcheanceParDefaut'],
      exerciceEnCours:
      json['exerciceEnCours'] != null ? Exercice.fromJson(json['exerciceEnCours']) : null,
      paysResidence:
      json['paysResidence'] != null ? Pays.fromJson(json['paysResidence']) : null,
      archivedAt: json['archivedAt'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'nomComplet': nomComplet,
      'email': email,
      'telephone': telephone,
      'whatsapp': whatsapp,
      'localisation': localisation,
      'photo': photo,
      'dateEcheanceParDefaut': dateEcheanceParDefaut,
      'exerciceEnCours': exerciceEnCours?.toJson(),
      'paysResidence': paysResidence?.toJson(),
      'archivedAt': archivedAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}