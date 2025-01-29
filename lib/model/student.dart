import 'package:hive/hive.dart';

part 'student.g.dart';

@HiveType(typeId: 0)
class Student {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int age;

  @HiveField(3)
  final String course;

  @HiveField(4)
  final String? imagePath;

  Student({
    required this.id,
    required this.name,
    required this.age,
    required this.course,
    this.imagePath,
  });
}
