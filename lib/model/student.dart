import 'package:hive/hive.dart';
part 'student.g.dart';

@HiveType(typeId: 1)
class Student {
  @HiveField(0)
  String id;
  @HiveField(1)
  String fullName;
  @HiveField(2)
  String email;
  @HiveField(3)
  String profileImg;
  @HiveField(4)
  DateTime dop;
  @HiveField(5)
  String phone;
  @HiveField(6)
  String department;
  @HiveField(7)
  String plan;
  Student({
    required this.id,
    required this.fullName,
    required this.email,
    required this.profileImg,
    required this.dop,
    required this.phone,
    required this.department,
    required this.plan,
  });
}
