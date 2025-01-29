import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_mng_getx/model/student.dart';
import 'package:student_mng_getx/screens/student_list_screen.dart';
import 'package:student_mng_getx/services/student_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(StudentAdapter());

  final studentService = StudentService();
  await studentService.init(); // Ensure initialization completes

  runApp(MyApp(studentService: studentService));
}

class MyApp extends StatelessWidget {
  final StudentService studentService;

  const MyApp({super.key, required this.studentService});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Management',
      initialBinding: BindingsBuilder(() {
        Get.put(studentService); // Register initialized service
      }),
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const StudentListScreen(),
    );
  }
}
