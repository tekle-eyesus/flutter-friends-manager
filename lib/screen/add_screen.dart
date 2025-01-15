import 'dart:io';
import 'package:class_1/controllers/box_controller.dart';
import 'package:class_1/model/student.dart';
import 'package:class_1/widget/custom_tf.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  File? pickedImage;
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
    String selectedCategory = "software engineer";

    List<String> departmentList = [
      "software engineer",
      "IS",
      "CS",
      "IT",
      "Mechanical Engineer"
    ];

    Future<void> _pickImage() async {
      final ImagePicker piker = ImagePicker();
      XFile? image = await piker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          pickedImage = File(image.path);
          print("file name ::::::${pickedImage}");
        });
      }
    }

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              await _pickImage();
            },
            child: Stack(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.amber,
                  backgroundImage:
                      pickedImage != null ? FileImage(pickedImage!) : null,
                  radius: 65,
                ),
                if (pickedImage == null)
                  const CircleAvatar(
                    backgroundColor: Colors.amber,
                    // backgroundImage: FileImage(pickedImage!),
                    radius: 60,
                  ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset(
                    "assets/icons/camera.png",
                    width: 32,
                    height: 32,
                  ),
                ),
              ],
            ),
          ),
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.of(context).size.width,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade300,
            ),
            child: ListTile(
              leading: Image.asset(
                "assets/icons/birthday.png",
                width: 30,
                height: 30,
              ),
              title: Text(
                '${selectedDate.year}-0${selectedDate.month}-0${selectedDate.day}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              trailing: IconButton(
                onPressed: () async {
                  final DateTime? dateTime = await showDatePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(3000),
                      initialDate: selectedDate);
                  if (dateTime != null) {
                    setState(
                      () {
                        selectedDate = dateTime;
                      },
                    );
                  }
                },
                icon: const Icon(
                  Icons.calendar_month_rounded,
                  size: 30,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: "department",
              labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              fillColor: Colors.grey.shade300,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            value: selectedCategory, // Initial value
            items: departmentList.map(
              (String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              },
            ).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedCategory = newValue!;
              });
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
                  department: selectedCategory,
                  plan: planController.text);
              BoxServices().addStudent(student, context);
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
