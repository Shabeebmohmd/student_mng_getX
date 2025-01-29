import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_mng_getx/services/student_service.dart';
import 'package:student_mng_getx/widget/student_tile.dart';
import 'add_student_screen.dart';

class StudentListScreen extends StatelessWidget {
  const StudentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentService studentService = Get.find();

    return Scaffold(
      appBar: AppBar(title: const Text('Students')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        onPressed: () => Get.to(() => const AddStudentScreen()),
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        if (studentService.students.isEmpty) {
          return const Center(child: Text("No students found"));
        }
        return ListView.builder(
          itemCount: studentService.students.length,
          itemBuilder:
              (ctx, index) =>
                  StudentTile(student: studentService.students[index]),
        );
      }),
    );
  }
}
