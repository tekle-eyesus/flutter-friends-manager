import 'dart:math';

import 'package:class_1/controllers/box_controller.dart';
import 'package:class_1/helper/helper_fun.dart';
import 'package:class_1/model/student.dart';
import 'package:class_1/widget/custom_tf.dart';
import 'package:class_1/widget/date_picker.dart';
import 'package:class_1/widget/dept_selector.dart';
import 'package:class_1/widget/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  String pickedImage = "";
  DateTime selectedDate = DateTime.now();

  ///
  ///
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController planController = TextEditingController();
  String selectedDpt = "software engineer";
  BoxServices boxServices = BoxServices();

  void selectDate(DateTime date) {
    selectedDate = date;
    print(selectedDate);
  }

  void selectDepartment(String department) {
    selectedDpt = department;
  }

  void selectImage(String pickedImg) {
    pickedImage = pickedImg; // covert to file when used
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade800,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade600,
        foregroundColor: Colors.grey.shade100,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.topLeft,
                colors: <Color>[Colors.purple.shade800, Colors.blue.shade900]),
          ),
        ),
        title: Text(
          "ADD",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.grey.shade100,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          // color: Colors.grey.shade400,
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 153, 201, 241),
            Color.fromARGB(255, 137, 206, 239),
          ]),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              ImageSelector(onImageSelect: (x) {
                selectImage(x);
              }),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                  labelText: "Full Name",
                  icon: Icons.person,
                  controller: nameController),
              CustomTextField(
                  labelText: "email",
                  icon: Icons.email,
                  controller: emailController),
              const SizedBox(
                height: 10,
              ),
              IntlPhoneField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(15),
                  filled: true,
                  fillColor: Color.fromARGB(255, 197, 237, 255),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  labelText: 'Phone Number',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  labelStyle: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                initialCountryCode: 'ET',
                onChanged: (phone) {
                  print(phone.completeNumber);
                },
              ),
              const SizedBox(
                height: 6,
              ),
              DatePicker(onDateSelected: (date) {
                selectDate(selectedDate);
              }),
              const SizedBox(
                height: 20,
              ),
              departmentBtn(
                onCategorySelect: (x) {
                  selectDepartment(selectedDpt);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: planController,
                decoration: InputDecoration(
                  hintText: "Write your plan....",
                  fillColor: const Color.fromARGB(255, 197, 237, 255),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                maxLines: 3,
              ),
              const SizedBox(
                height: 17,
              ),
              GestureDetector(
                onTap: () {
                  //input validation via snak bar with red color
                  if (emailController.text.isNotEmpty ||
                      phoneController.text.isNotEmpty ||
                      nameController.text.isNotEmpty ||
                      planController.text.isNotEmpty ||
                      pickedImage != "") {
                    // add the student to db
                    Student student = Student(
                        id: Random().nextInt(1000).toString(),
                        fullName: nameController.text,
                        email: emailController.text,
                        profileImg: pickedImage.toString(),
                        dop: selectedDate,
                        phone: phoneController.text,
                        department: selectedDpt,
                        plan: planController.text);
                    boxServices.addStudent(student, context);
                    Navigator.pop(context);
                  } else {
                    DisplayMessage(
                        context, "Please fill in all required fields!");
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                      colors: [
                        const Color.fromARGB(255, 18, 135, 231),
                        const Color.fromARGB(255, 150, 83, 249),
                      ],
                    ),
                  ),
                  child: Text(
                    "ADD",
                    style: TextStyle(
                      color: Colors.grey.shade100,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildUi(BuildContext context) {
  //   TextEditingController nameController = TextEditingController();
  //   TextEditingController emailController = TextEditingController();
  //   TextEditingController dobController = TextEditingController();
  //   TextEditingController phoneController = TextEditingController();
  //   TextEditingController planController = TextEditingController();
  //   String selectedDpt = "software engineer";
  //   BoxServices boxServices = BoxServices();

  //   void selectDate(DateTime date) {
  //     selectedDate = date;
  //   }

  //   void selectDepartment(String department) {
  //     selectedDpt = department;
  //   }

  //   void selectImage(String pickedImg) {
  //     pickedImage = pickedImg; // covert to file when used
  //   }

  //   return Padding(
  //     padding: const EdgeInsets.all(15.0),
  //     child: ListView(
  //       keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
  //       children: [
  //         ImageSelector(onImageSelect: (x) {
  //           selectImage(x);
  //         }),
  //         const SizedBox(
  //           height: 10,
  //         ),
  //         CustomTextField(
  //             labelText: "Full Name",
  //             icon: Icons.person,
  //             controller: nameController),
  //         CustomTextField(
  //             labelText: "email",
  //             icon: Icons.email,
  //             controller: emailController),
  //         const SizedBox(
  //           height: 10,
  //         ),
  //         IntlPhoneField(
  //           controller: phoneController,
  //           keyboardType: TextInputType.phone,
  //           decoration: InputDecoration(
  //             contentPadding: const EdgeInsets.all(15),
  //             filled: true,
  //             fillColor: Colors.grey.shade300,
  //             border: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(8),
  //               borderSide: BorderSide.none,
  //             ),
  //             labelText: 'Phone Number',
  //             focusedBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(12),
  //               borderSide: BorderSide(
  //                 color: Theme.of(context).colorScheme.primary,
  //                 width: 2,
  //               ),
  //             ),
  //             labelStyle: TextStyle(
  //               color:
  //                   Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //           initialCountryCode: 'ET',
  //           onChanged: (phone) {
  //             print(phone.completeNumber);
  //           },
  //         ),
  //         const SizedBox(
  //           height: 6,
  //         ),
  //         DatePicker(onDateSelected: (date) {
  //           selectDate(selectedDate);
  //         }),
  //         const SizedBox(
  //           height: 20,
  //         ),
  //         departmentBtn(
  //           onCategorySelect: (x) {
  //             selectDepartment(selectedDpt);
  //           },
  //         ),
  //         const SizedBox(
  //           height: 10,
  //         ),
  //         TextField(
  //           controller: planController,
  //           decoration: InputDecoration(
  //             hintText: "Write your plan....",
  //             fillColor: Colors.grey.shade300,
  //             filled: true,
  //             border: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(10),
  //               borderSide: BorderSide.none,
  //             ),
  //           ),
  //           maxLines: 3,
  //         ),
  //         const SizedBox(
  //           height: 17,
  //         ),
  //         GestureDetector(
  //           onTap: () {
  //             //input validation via snak bar with red color
  //             if (emailController.text.isNotEmpty ||
  //                 phoneController.text.isNotEmpty ||
  //                 nameController.text.isNotEmpty ||
  //                 planController.text.isNotEmpty ||
  //                 pickedImage != "") {
  //               // add the student to db
  //               Student student = Student(
  //                   id: Random().nextInt(1000).toString(),
  //                   fullName: nameController.text,
  //                   email: emailController.text,
  //                   profileImg: pickedImage.toString(),
  //                   dop: selectedDate,
  //                   phone: phoneController.text,
  //                   department: selectedDpt,
  //                   plan: planController.text);
  //               boxServices.addStudent(student, context);
  //               Navigator.pop(context);
  //             } else {
  //               DisplayMessage(context, "Please fill in all required fields!");
  //             }
  //           },
  //           child: Container(
  //             alignment: Alignment.center,
  //             width: MediaQuery.of(context).size.width,
  //             height: 60,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(8),
  //               gradient: LinearGradient(
  //                 colors: [
  //                   Colors.grey.shade900,
  //                   Colors.grey.shade800,
  //                 ],
  //               ),
  //             ),
  //             child: Text(
  //               "ADD",
  //               style: TextStyle(
  //                 color: Colors.grey.shade100,
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 20,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
