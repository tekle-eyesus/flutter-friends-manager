import 'package:hive/hive.dart';
part 'student.g.dart';

@HiveType(typeId: 1)
class Student {
  @HiveField(0)
  String fullName;
  @HiveField(1)
  String email;
  @HiveField(2)
  String profileImg;
  @HiveField(3)
  DateTime dop;
  @HiveField(4)
  String phone;
  @HiveField(5)
  String department;
  @HiveField(6)
  String plan;
  Student({
    required this.fullName,
    required this.email,
    required this.profileImg,
    required this.dop,
    required this.phone,
    required this.department,
    required this.plan,
  });
}
