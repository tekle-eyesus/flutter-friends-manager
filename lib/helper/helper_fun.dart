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
  TextEditingController nameController =
      TextEditingController(text: student.fullName);
  TextEditingController departmentController =
      TextEditingController(text: student.department);
  TextEditingController phoneController =
      TextEditingController(text: student.phone);
  TextEditingController planController =
      TextEditingController(text: student.plan);
  TextEditingController emailController =
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
                controller: nameController,
              ),
              const SizedBox(
                height: 7,
              ),
              TextField(
                decoration: inputDecoration(),
                controller: phoneController,
              ),
              const SizedBox(
                height: 7,
              ),
              TextField(
                decoration: inputDecoration(),
                controller: departmentController,
              ),
              const SizedBox(
                height: 7,
              ),
              TextField(
                decoration: inputDecoration(),
                controller: planController,
              ),
              const SizedBox(
                height: 7,
              ),
              TextField(
                decoration: inputDecoration(),
                controller: emailController,
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
                    fullName: nameController.text,
                    email: emailController.text,
                    profileImg: student.profileImg,
                    dop: student.dop,
                    phone: phoneController.text,
                    department: departmentController.text,
                    plan: planController.text,
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
    duration: const Duration(seconds: 1),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void DisplayDeleteMessage(BuildContext context, String mesg, Student student) {
  final snackBar = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          mesg,
          style: const TextStyle(color: Colors.white),
        ),
        TextButton(
            style: ButtonStyle(
              padding: const MaterialStatePropertyAll(EdgeInsets.zero),
              backgroundColor: MaterialStatePropertyAll(
                Colors.grey.shade800,
              ),
            ),
            onPressed: () {
              // add logic
              BoxServices().addStudent(student, context);
            },
            child: const Text(
              "UNDO",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ))
      ],
    ),
    backgroundColor: Colors.grey.shade900,
    duration: const Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
