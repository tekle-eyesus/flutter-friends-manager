import 'package:class_1/box/student_box.dart';
import 'package:class_1/helper/helper_fun.dart';
import 'package:class_1/model/student.dart';
import 'package:flutter/material.dart';

class BoxServices {
  //fields
  void addStudent(Student student, BuildContext context) async {
    try {
      await studentBox.put(student.id, student);
      DisplayMessage(context, "Student data added");
    } catch (e) {
      print(e);
    }
  }

  void deleteStudent(int index, BuildContext context) {
    studentBox.deleteAt(index);
    DisplayMessage(context, "Student Deleted!");
  }

  void updateStudent(Student student, BuildContext context) {
    print("Full Name of the Student : " + student.phone);
    studentBox.put(student.id, student);
    DisplayMessage(context, "Student Data updated!!");
  }
}
