import 'bailleur.dart';

class Locataire {
  final int id;
  final String code;
  final String nomComplet;
  final String? email;
  final String telephone;
  final String adresseLogement;
  final String? photo;
  final int dateEcheance;
  final double montantLoyer;
  final String? statut;
  final Bailleur? bailleur;
  final String? archivedAt;
  final String? createdAt;
  final String? updatedAt;

  Locataire({
    required this.id,
    required this.code,
    required this.nomComplet,
    this.email,
    required this.telephone,
    required this.adresseLogement,
    this.photo,
    required this.dateEcheance,
    required this.montantLoyer,
    this.statut,
    this.bailleur,
    this.archivedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Locataire.fromJson(Map<String, dynamic> json) {
    return Locataire(
      id: json['id'],
      code: json['code'],
      nomComplet: json['nomComplet'],
      email: json['email'],
      telephone: json['telephone'],
      adresseLogement: json['adresseLogement'],
      photo: json['photo'],
      dateEcheance: json['dateEcheance'] ?? 0,
      montantLoyer: (json['montantLoyer'] as num).toDouble(),
      statut: json['statut'],
      bailleur: json['bailleur'] != null ? Bailleur.fromJson(json['bailleur']) : null,
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
      'adresseLogement': adresseLogement,
      'photo': photo,
      'dateEcheance': dateEcheance,
      'montantLoyer': montantLoyer,
      'statut': statut,
      'bailleur': bailleur?.toJson(),
      'archivedAt': archivedAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
