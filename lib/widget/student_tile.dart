import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_mng_getx/model/student.dart';
import 'package:student_mng_getx/screens/edit_student_screen.dart';
import 'package:student_mng_getx/screens/student_detail_screen.dart';
import 'package:student_mng_getx/services/student_service.dart';

class StudentTile extends StatelessWidget {
  final Student student;

  const StudentTile({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    final StudentService studentService = Get.find();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        tileColor: Colors.blueGrey[100],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          student.name,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(student.course),
        leading:
            student.imagePath != null
                ? CircleAvatar(
                  backgroundImage: FileImage(File(student.imagePath!)),
                )
                : null,
        onTap: () => Get.to(() => StudentDetailScreen(student: student)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed:
                  () => Get.to(() => EditStudentScreen(student: student)),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => studentService.deleteStudent(student.id),
            ),
          ],
        ),
      ),
    );
  }
}
