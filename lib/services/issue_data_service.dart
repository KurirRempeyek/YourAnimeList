import 'package:http/http.dart' as http;
import 'package:prototyping/dto/issue.dart';
import 'dart:convert';
import 'package:prototyping/endpoints/csendpoint.dart';

class IssueDataService {
  static Future<List<Issue>> fetchIssue() async {
    final response = await http.get(Uri.parse(Endpoints.issue));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['Issue'] as List<dynamic>)
          .map((item) => Issue.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      // Handle error
      throw Exception('Failed to load data');
    }
  }

  static Future<void> deleteIssue(int id) async {
    await http.delete(Uri.parse('${Endpoints.issue}/$id'),
        headers: {'Content-type': 'aplication/json'});
  }

  static Future<void> updateIssue(String id, String title, String body) async {
    Map<String, String> data = {"id": id, "title": title, "body": body};
    String jsonData = jsonEncode(data);
    await http.put(Uri.parse('${Endpoints.issue}/$id'),
        body: jsonData, headers: {'Content-type': 'application/json'});
  }
}
