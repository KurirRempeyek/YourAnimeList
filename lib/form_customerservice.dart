import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prototyping/endpoints/endpoints.dart';

class CSForm extends StatefulWidget {
  const CSForm({Key? key}) : super(key: key);

  @override
  _CSFormState createState() => _CSFormState();
}

class _CSFormState extends State<CSForm> {
  final _titleController = TextEditingController();
  String _title = "";

  final _descriptionController = TextEditingController();
  String _description = "";

  String? _selectedDivision;
  String? _selectedPriority;

  File? galleryFile;
  final picker = ImagePicker();

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
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  saveData() {
    debugPrint(_title);
    debugPrint(_description);
  }

  double rating = 0;
  void ratingUpdate(double userRating) {
    setState(() {
      rating = userRating;
    });
  }

  Future<void> _postDataWithImage(BuildContext context) async {
    if (galleryFile == null) {
      return;
    }

    var request = MultipartRequest('POST', Uri.parse(Endpoints.issue));
    request.fields['title_issues'] = _titleController.text;
    request.fields['description_issues'] = _descriptionController.text;
    request.fields['rating'] = rating.toString();

    var multipartFile = await MultipartFile.fromPath(
      'image',
      galleryFile!.path,
    );
    request.files.add(multipartFile);

    request.send().then((response) {
      if (response.statusCode == 201) {
        debugPrint('Data and image posted successfully!');
        Navigator.of(context).pop();
      } else {
        debugPrint('Error posting data: ${response.statusCode}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade900,
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
                    "Report Issue",
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
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60)),
                ),
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
                                  color: Color.fromARGB(255, 82, 80, 80),
                                  blurRadius: 10,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(
                          children: [
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
                            Text(
                              'Rating',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            RatingBar(
                              minRating: 1,
                              maxRating: 5,
                              allowHalfRating: false,
                              ratingWidget: RatingWidget(
                                full: const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                half: const Icon(
                                  Icons.star_half,
                                  color: Colors.yellow,
                                ),
                                empty: const Icon(
                                  Icons.star_border,
                                  color: Colors.yellow,
                                ),
                              ),
                              onRatingUpdate: ratingUpdate,
                            ),
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
                                        child: Text('Put Image Here',
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: const Color.fromARGB(
                                                  255, 124, 122, 122),
                                              fontWeight: FontWeight.w500,
                                            )))
                                    : Center(
                                        child: Image.file(galleryFile!),
                                      ),
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
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
        tooltip: 'Increment',
        onPressed: () {
          _postDataWithImage(context);
        },
        child: const Icon(Icons.save, color: Colors.white, size: 28),
      ),
    );
  }
}
