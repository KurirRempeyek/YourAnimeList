import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prototyping/form_customerservice.dart';
//import 'package:prototyping/form_customerservice.dart';

class CustomerService extends StatefulWidget {
  const CustomerService({super.key});

  @override
  State<CustomerService> createState() => _CustomerServiceState();
}

class _CustomerServiceState extends State<CustomerService> {
  List<Issue> _issues = [];

  @override
  void initState() {
    super.initState();
    //_fetchIssue();
  }

  //UNTUK DI SERVICES
  //void _fetchIssues() async {
  // Ganti URL API dengan URL API sebenarnya
  //final response = await http.get(Uri.parse('https://your-api-url/issues'));
  //if (response.statusCode == 200) {
  //final data = jsonDecode(response.body) as List<dynamic>;
  //setState(() {
  //_issues = data.map((issue) => Issue.fromJson(issue)).toList();
  //});
  //} else {
  // Handle error
  //print('Error fetching issues: ${response.statusCode}');
  //}
  //}

  void _addIssue() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FormCS()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Issue List',
          style: GoogleFonts.poppins(fontSize: 25),
        ),
        backgroundColor: const Color.fromARGB(255, 103, 80, 164),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _issues.length,
              itemBuilder: (context, index) {
                final issue = _issues[index];
                return ListTile(
                  title: Text(issue.title),
                  subtitle: Text(issue.description),
                  onTap: () {
                    //tampilkan detail issue
                  },
                );
              },
            ),
          ),
          FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 103, 80, 164),
            tooltip: 'Increment',
            onPressed: _addIssue,
            child: const Icon(Icons.add, color: Colors.white, size: 28),
          ),
        ],
      ),
    );
  }
}

//BUAT FILE BARU
class Issue {
  final String title;
  final String description;

  Issue({required this.title, required this.description});

  factory Issue.fromJson(Map<String, dynamic> json) {
    return Issue(
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }
}
