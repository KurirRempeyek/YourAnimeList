class Spendings {
  final int idSpending;
  final int spending;
  final String nim;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  Spendings({
    required this.idSpending,
    required this.spending,
    required this.nim,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Spendings.fromJson(Map<String, dynamic> json) {
    return Spendings(
      idSpending: json['id_spending'] as int,
      spending: json['spending'] as int,
      nim: json['nim'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'] as String)
          : null,
    );
  }
}
