// To parse this JSON data, do
//
//     final issue = issueFromJson(jsonString);

import 'dart:convert';

Issue issueFromJson(String str) => Issue.fromJson(json.decode(str));

String issueToJson(Issue data) => json.encode(data.toJson());

class Issue {
  int idCustomerService;
  String nim;
  String titleIssues;
  String descriptionIssues;
  int rating;
  String imageUrl;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  Issue({
    required this.idCustomerService,
    required this.nim,
    required this.titleIssues,
    required this.descriptionIssues,
    required this.rating,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory Issue.fromJson(Map<String, dynamic> json) => Issue(
        idCustomerService: json["id_customer_service"],
        nim: json["nim"],
        titleIssues: json["title_issues"],
        descriptionIssues: json["description_issues"],
        rating: json["rating"],
        imageUrl: json["image_url"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id_customer_service": idCustomerService,
        "nim": nim,
        "title_issues": titleIssues,
        "description_issues": descriptionIssues,
        "rating": rating,
        "image_url": imageUrl,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
