import 'package:class_1/box/student_box.dart';
import 'package:class_1/helper/helper_fun.dart';
import 'package:class_1/model/student.dart';
import 'package:flutter/material.dart';

class BoxServices {
  //fields
  void addStudent(Student student, BuildContext context) async {
    try {
      await studentBox.put(student.id, student);
      DisplayMessage(context, "Student added successfully!");
    } catch (e) {
      print(e);
    }
  }

  void deleteStudent(int index, BuildContext context) {
    Student studentData = studentBox.getAt(index);
    studentBox.deleteAt(index);
    DisplayDeleteMessage(context, "Student deleted successfully!", studentData);
  }

  void updateStudent(Student student, BuildContext context) {
    studentBox.put(student.id, student);
    DisplayMessage(context, "Student data updated successfully!");
  }
}
