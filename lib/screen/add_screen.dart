import 'dart:io';
import 'package:class_1/controllers/box_controller.dart';
import 'package:class_1/model/student.dart';
import 'package:class_1/widget/custom_tf.dart';
import 'package:class_1/widget/date_picker.dart';
import 'package:class_1/widget/dept_selector.dart';
import 'package:class_1/widget/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  String pickedImage = "";
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade600,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade600,
        foregroundColor: Colors.grey.shade100,
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
            color: Colors.grey.shade400,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(15),
            ),
          ),
          child: _buildUi(context)),
    );
  }

  Widget _buildUi(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController dobController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController planController = TextEditingController();
    String selectedDpt = "software engineer";
    BoxServices boxServices = BoxServices();

    void selectDate(DateTime date) {
      selectedDate = date;
    }

    void selectDepartment(String department) {
      selectedDpt = department;
    }

    void selectImage(String pickedImg) {
      pickedImage = pickedImg; // covert to file when used
    }

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
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
              fillColor: Colors.grey.shade300,
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
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
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
              fillColor: Colors.grey.shade300,
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
              // add the student to db
              Student student = Student(
                  fullName: nameController.text,
                  email: emailController.text,
                  profileImg: pickedImage.toString(),
                  dop: selectedDate,
                  phone: phoneController.text,
                  department: selectedDpt,
                  plan: planController.text);
              boxServices.addStudent(student, context);
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  colors: [
                    Colors.grey.shade900,
                    Colors.grey.shade800,
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
    );
  }
}
