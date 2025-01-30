import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:student_mng_getx/model/student.dart';

class StudentService extends GetxController {
  final RxList<Student> students = <Student>[].obs;
  late Box<Student> _studentsBox;

  Future<void> init() async {
    _studentsBox = await Hive.openBox<Student>('students');
    students.assignAll(_studentsBox.values);
  }

  Future<void> addStudent(Student student) async {
    await _studentsBox.put(student.id, student);
    students.assignAll(_studentsBox.values);
  }

  Future<void> updateStudent(Student student) async {
    await _studentsBox.put(student.id, student);
    students.assignAll(_studentsBox.values);
  }

  Future<void> deleteStudent(String id) async {
    await _studentsBox.delete(id);
    students.assignAll(_studentsBox.values);
  }
}
