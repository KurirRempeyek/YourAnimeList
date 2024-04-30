import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prototyping/dto/issue.dart';
import 'package:prototyping/endpoints/endpoints.dart';
import 'package:prototyping/issue_list_screen.dart';

class EditCS extends StatefulWidget {
  const EditCS({Key? key, required this.edit}) : super(key: key);

  final Issue edit;

  @override
  State<EditCS> createState() => _EditCSState();
}

class _EditCSState extends State<EditCS> {
  final _titleController = TextEditingController();
  String _title = "";
  final _ratingController = TextEditingController();
  int _rating = 0;
  final _descriptionController = TextEditingController();
  String _description = "";

  File? galleryFile;
  final picker = ImagePicker();

  String? _selectedDivision;
  String? _selectedPriority;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.edit.titleIssues;
    _descriptionController.text = widget.edit.descriptionIssues;
  }

  _showPicker({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getImage(
    ImageSource img,
  ) async {
    final pickedFile = await picker.pickImage(source: img);
    XFile? xfilePick = pickedFile;
    setState(
      () {
        if (xfilePick != null) {
          galleryFile = File(pickedFile!.path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nothing is Selected')));
        }
      },
    );
  }

  Future<void> _updateDataWithImage(BuildContext context) async {
    if (galleryFile == null) {
      return; // Kalau ga ada image
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _ratingController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  double rating = 0;
  void ratingUpdate(double userRating) {
    setState(() {
      rating = userRating;
    });
  }

  Future<void> _updateIssueWithImage(BuildContext context) async {
    if (galleryFile == null) {
      return;
    }

    var request = MultipartRequest('POST',
        Uri.parse('${Endpoints.issue}/${widget.edit.idCustomerService}'));
    request.fields['title_issues'] = _titleController.text;
    request.fields['description_issues'] = _descriptionController.text;
    request.fields['rating'] = rating.toDouble() as String;
    if (galleryFile != null) {
      var multipartFile = await MultipartFile.fromPath(
        'image',
        galleryFile!.path,
      );
      request.files.add(multipartFile);
    }

    request.send().then((response) {
      // Handle response (success or error)
      if (response.statusCode == 200) {
        debugPrint('Issue edited successfully!');
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const IssueListScreen()));
      } else {
        debugPrint('Error posting data: ${response.statusCode}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade900,
      appBar: AppBar(
        title: null,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Edit Report",
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    "Fill the form belom before submitting!",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(225, 95, 27, .3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showPicker(context: context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200))),
                                width: double.infinity,
                                height: 150,
                                child: galleryFile == null
                                    ? Center(
                                        child: Image.network(
                                          width: 200,
                                          Uri.parse(
                                                  '${Endpoints.baseURLLive}/public/${widget.edit.imageUrl!}')
                                              .toString(),
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  const Icon(Icons.error),
                                        ),
                                      )
                                    : Center(
                                        child: Image.file(galleryFile!),
                                      ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade200))),
                              child: TextField(
                                  controller: _titleController,
                                  decoration: const InputDecoration(
                                      hintText: "Title of Issue",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                  onChanged: (value) {
                                    setState(() {
                                      _title = value;
                                    });
                                  }),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade200))),
                              child: TextField(
                                controller: _ratingController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    hintText: "Rating (1-5)",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                                onChanged: (value) {
                                  setState(() {
                                    _rating = int.tryParse(value) ?? 0;
                                  });
                                },
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade200))),
                              child: TextField(
                                controller: _descriptionController,
                                decoration: const InputDecoration(
                                    hintText: "Issue Description",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                                onChanged: (value) {
                                  setState(() {
                                    _description = value;
                                  });
                                },
                              ),
                            ),
                            DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                hintText: 'Select Division',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                              value: _selectedDivision,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedDivision = newValue!;
                                });
                              },
                              items: <String>[
                                'IT',
                                'Helpdesk',
                                'Billing'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                hintText: 'Select Priority',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                              value: _selectedPriority,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedPriority = newValue!;
                                });
                              },
                              items: <String>[
                                'High',
                                'Medium',
                                'Low'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
        tooltip: 'Increment',
        onPressed: () {
          _updateDataWithImage(context);
        },
        child: const Icon(Icons.save, color: Colors.white, size: 28),
      ),
    );
  }
}
