import 'package:http/http.dart' as http;
import 'package:prototyping/dto/datas.dart';
import 'package:prototyping/dto/issue.dart';
import 'dart:convert';
import 'package:prototyping/dto/news.dart';
import 'package:prototyping/endpoints/endpoints.dart';

class DataService {
  static Future<List<News>> fetchNews() async {
    final response = await http.get(Uri.parse(Endpoints.news));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((item) => News.fromJson(item)).toList();
    } else {
      // Handle error
      throw Exception('Failed to load news');
    }
  }

  static Future<void> sendNews(String title, String body) async {
    Map<String, String> newsData = {
      "title": title,
      "body": body,
    };
    String jsonData = jsonEncode(newsData);
    await http.post(Uri.parse(Endpoints.news),
        body: jsonData, headers: {'Content-Type': 'application/json'});
  }

  static Future<List<Datas>> fetchDatas() async {
    final response = await http.get(Uri.parse(Endpoints.datas));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>)
          .map((item) => Datas.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      // Handle error
      throw Exception('Failed to load data');
    }
  }

  static Future<void> deleteDatas(int id) async {
    await http.delete(Uri.parse('${Endpoints.datas}/$id'),
        headers: {'Content-type': 'aplication/json'});
  }

  static Future<void> updateDatas(String id, String title, String body) async {
    Map<String, String> data = {"id": id, "title": title, "body": body};
    String jsonData = jsonEncode(data);
    await http.put(Uri.parse('${Endpoints.datas}/$id'),
        body: jsonData, headers: {'Content-type': 'application/json'});
  }

  // post data to endpoint news
  static Future<News> createNews(String title, String body) async {
    final response = await http.post(
      Uri.parse(Endpoints.news),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'body': body,
      }),
    );

    if (response.statusCode == 201) {
      // Check for creation success (201 Created)
      final jsonResponse = jsonDecode(response.body);
      return News.fromJson(jsonResponse);
    } else {
      // Handle error
      throw Exception('Failed to create post: ${response.statusCode}');
    }
  }

  static Future<List<Issue>> fetchCustomerService() async {
    final response = await http.get(Uri.parse(Endpoints.issue));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>)
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
}
