import 'dart:io';

import 'package:class_1/model/student.dart';
import 'package:flutter/material.dart';

String getDate(DateTime date) {
  String month = date.month.toString();
  String day = date.day.toString();

  if (month.length == 1) {
    month = "0${date.month}";
  }
  if (day.length == 1) {
    day = "0${date.day}";
  }
  String dateFormat = '${date.year}-$month-$day';
  return dateFormat;
}

void showEditDialog(BuildContext ctx, Student student) {
  TextEditingController _nameController =
      TextEditingController(text: student.fullName);
  TextEditingController _departmentController =
      TextEditingController(text: student.department);
  TextEditingController _phoneController =
      TextEditingController(text: student.phone);
  TextEditingController _planController =
      TextEditingController(text: student.plan);

  showDialog(
      context: ctx,
      builder: (context) {
        return AlertDialog(
          title: const Text("edit"),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              //image
              CircleAvatar(
                radius: 35,
                backgroundImage: FileImage(File(student.profileImg)),
              ),
              TextField(
                controller: _nameController,
              ),
              TextField(
                controller: _phoneController,
              ),
              TextField(
                controller: _departmentController,
              ),
              TextField(
                controller: _planController,
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  //update logic here
                },
                child: Text("Save")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel")),
          ],
        );
      });
}
