class Exercice {
  final int id;
  final String code;
  final bool actif;
  final String createdAt;
  final String updatedAt;

  Exercice({
    required this.id,
    required this.code,
    required this.actif,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Exercice.fromJson(Map<String, dynamic> json) {
    return Exercice(
      id: json['id'],
      code: json['code'],
      actif: json['actif'] ?? false,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'actif': actif,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}