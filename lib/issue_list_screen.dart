import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prototyping/components/bottom_up_transition.dart';
import 'package:prototyping/dto/issue.dart';
import 'package:prototyping/edit_cs.dart';
import 'package:prototyping/endpoints/csendpoint.dart';
import 'package:prototyping/form_customerservice.dart';
import 'package:prototyping/services/issue_data_service.dart';

class CustomerService extends StatefulWidget {
  const CustomerService({super.key});

  @override
  State<CustomerService> createState() => _CustomerServiceState();
}

class _CustomerServiceState extends State<CustomerService> {
  Future<List<Issue>>? _issue;

  @override
  void initState() {
    super.initState();
    _issue = IssueDataService.fetchIssue();
  }

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
      body: FutureBuilder<List<Issue>>(
        future: _issue,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return ListTile(
                  // ignore: unnecessary_null_comparison
                  title: item.imageUrl == null
                      ? Row(
                          children: [
                            Image.network(
                              fit: BoxFit.fitWidth,
                              width: 350,
                              Uri.parse(
                                      '${Endpoints.baseURL}/public/${item.imageUrl}')
                                  .toString(),
                              errorBuilder: (context, error, StackTrace) =>
                                  const Icon(Icons.error),
                            ),
                          ],
                        )
                      : null,
                  subtitle: Column(children: [
                    Text(
                      'Title: ${item.titleIssues}',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: const Color.fromARGB(255, 36, 31, 31),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            _showDeleteConfirmationDialog(context, item);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditCS(obyek: item)));
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    )
                  ]),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 54, 40, 176),
        tooltip: 'Increment',
        onPressed: () {
          Navigator.push(context, BottomUpRoute(page: const FormCS()));
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, Issue datas) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Confirmation'),
          content:
              Text('Are you sure you want to delete ${datas.titleIssues}?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                IssueDataService.deleteIssue(datas.idCustomerService);
                setState(() {
                  _issue = IssueDataService.fetchIssue();
                });
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
