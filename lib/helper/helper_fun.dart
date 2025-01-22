import 'dart:io';
import 'package:class_1/controllers/box_controller.dart';
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
  BoxServices boxServices = BoxServices();
  TextEditingController _nameController =
      TextEditingController(text: student.fullName);
  TextEditingController _departmentController =
      TextEditingController(text: student.department);
  TextEditingController _phoneController =
      TextEditingController(text: student.phone);
  TextEditingController _planController =
      TextEditingController(text: student.plan);
  TextEditingController _emailController =
      TextEditingController(text: student.email);

  InputDecoration inputDecoration() {
    return InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
        fillColor: Colors.blue.shade100,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ));
  }

  showDialog(
      context: ctx,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blue.shade200,
          title: Text(
            "Edit Student",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              //image
              GestureDetector(
                onTap: () {
                  //image update logic here
                },
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: FileImage(File(student.profileImg)),
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              TextField(
                decoration: inputDecoration(),
                controller: _nameController,
              ),
              const SizedBox(
                height: 7,
              ),
              TextField(
                decoration: inputDecoration(),
                controller: _phoneController,
              ),
              const SizedBox(
                height: 7,
              ),
              TextField(
                decoration: inputDecoration(),
                controller: _departmentController,
              ),
              const SizedBox(
                height: 7,
              ),
              TextField(
                decoration: inputDecoration(),
                controller: _planController,
              ),
              const SizedBox(
                height: 7,
              ),
              TextField(
                decoration: inputDecoration(),
                controller: _emailController,
              ),
            ],
          ),
          actions: [
            TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.blue.shade500),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.blue.shade100,
                  ),
                )),
            TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.blue.shade500),
                ),
                onPressed: () {
                  //update logic here
                  Student uptStudent = Student(
                    id: student.id,
                    fullName: _nameController.text,
                    email: _emailController.text,
                    profileImg: student.profileImg,
                    dop: student.dop,
                    phone: _phoneController.text,
                    department: _departmentController.text,
                    plan: _planController.text,
                  );
                  //send to controller
                  boxServices.updateStudent(uptStudent, context);
                  Navigator.pop(context);
                },
                child: Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.blue.shade100,
                  ),
                )),
          ],
        );
      });
}

void DisplayMessage(BuildContext context, String mesg) {
  final snackBar = SnackBar(
    content: Text(
      mesg,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.grey.shade900,
    duration: Duration(seconds: 1),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
