class Pays {
  final int id;
  final String intitule;
  final String codeIso;
  final String indicatif;
  final String createdAt;
  final String updatedAt;

  Pays({
    required this.id,
    required this.intitule,
    required this.codeIso,
    required this.indicatif,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Pays.fromJson(Map<String, dynamic> json) {
    return Pays(
      id: json['id'],
      intitule: json['intitule'],
      codeIso: json['codeIso'],
      indicatif: json['indicatif'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'intitule': intitule,
      'codeIso': codeIso,
      'indicatif': indicatif,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}