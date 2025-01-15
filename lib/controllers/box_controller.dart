import 'package:class_1/box/student_box.dart';
import 'package:class_1/model/student.dart';
import 'package:flutter/material.dart';

class BoxServices {
  //fields
  void addStudent(Student student, BuildContext context) async {
    try {
      await studentBox.put(student.fullName, student);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Student data added!!!")));
    } catch (e) {
      print(e);
    }
  }

  void deleteStudent(int index) {
    studentBox.deleteAt(index);
  }

  void updateStudent() {}
}
