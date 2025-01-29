import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_mng_getx/model/student.dart';

class StudentDetailScreen extends StatelessWidget {
  final Student student;

  const StudentDetailScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(student.name)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Circular avatar with image
              CircleAvatar(
                radius: 100,
                backgroundImage:
                    student.imagePath != null
                        ? FileImage(File(student.imagePath!))
                        : null,
                child:
                    student.imagePath == null
                        ? const Icon(Icons.person, size: 100)
                        : null,
              ),
              const SizedBox(height: 20),
              // Student details
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow('Name', student.name),
                      _buildDetailRow('Age', student.age.toString()),
                      _buildDetailRow('Course', student.course),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
