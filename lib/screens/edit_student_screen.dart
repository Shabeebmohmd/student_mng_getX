import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_mng_getx/model/student.dart';
import 'package:student_mng_getx/services/student_service.dart';

class EditStudentScreen extends StatefulWidget {
  final Student student;

  const EditStudentScreen({super.key, required this.student});

  @override
  _EditStudentScreenState createState() => _EditStudentScreenState();
}

class _EditStudentScreenState extends State<EditStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _courseController;
  File? _image;
  final StudentService studentService = Get.find();

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing student data
    _nameController = TextEditingController(text: widget.student.name);
    _ageController = TextEditingController(text: widget.student.age.toString());
    _courseController = TextEditingController(text: widget.student.course);
    _image =
        widget.student.imagePath != null
            ? File(widget.student.imagePath!)
            : null;
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Student')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(13)),
                    ),
                  ),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  controller: _ageController,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(13)),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
              ),
              TextFormField(
                controller: _courseController,
                decoration: const InputDecoration(
                  labelText: 'Course',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(13)),
                  ),
                ),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              _image != null
                  ? Image.file(_image!, height: 150)
                  : const Text('No image selected'),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  foregroundColor: Colors.white,
                ),
                onPressed: _pickImage,
                child: const Text('Pick Image'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Create updated student object
                    final updatedStudent = Student(
                      id: widget.student.id, // Keep same ID
                      name: _nameController.text,
                      age: int.parse(_ageController.text),
                      course: _courseController.text,
                      imagePath: _image?.path,
                    );

                    // Update in Hive
                    studentService.updateStudent(updatedStudent);
                    Get.back();
                  }
                },
                child: const Text('Update Student'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
