import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prototyping/dto/issue.dart';

class EditCS extends StatefulWidget {
  const EditCS({Key? key, required this.obyek}) : super(key: key);

  final Issue obyek;

  @override
  State<EditCS> createState() => _EditCState();
}

class _EditCState extends State<EditCS> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _ratingController = TextEditingController();
  File? galleryFile;

  void _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        galleryFile = File(pickedImage.path);
      });
    }
  }

  void _submitIssue() {
    if (_formKey.currentState!.validate()) {
      //proses submit issue ke server/database
      print('Title: ${_titleController}');
      print('Description: ${_descriptionController}');
      print('Rating: ${_ratingController}');
      print('Image: ${galleryFile?.path}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Report Issue',
          style: GoogleFonts.poppins(fontSize: 25),
        ),
        backgroundColor: const Color.fromARGB(255, 103, 80, 164),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title Issue',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Title can\'t be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Description Issue',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Description can\'t be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _ratingController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Rating (1-5)',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Rating have to be number 1 to 5';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: _pickImage,
                      child: const Text('Choose Image'),
                    ),
                    if (galleryFile != null)
                      Image.file(galleryFile!, width: 100.0, height: 100.0),
                  ],
                ),
                const SizedBox(
                  height: 32.0,
                ),
                ElevatedButton(
                  onPressed: _submitIssue,
                  child: const Text('Report'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
