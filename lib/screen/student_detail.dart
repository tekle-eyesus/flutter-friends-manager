import 'dart:io';

import 'package:class_1/model/student.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentDetail extends StatelessWidget {
  final Student student;

  const StudentDetail({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 222, 238, 252),
      appBar: AppBar(
        foregroundColor: Colors.grey.shade200,
        title: Text(
          "Sudent Detail",
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade300,
              fontSize: 19,
            ),
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.topLeft,
                colors: <Color>[Colors.purple.shade800, Colors.blue.shade900]),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit,
              ))
        ],
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 115,
            decoration: const BoxDecoration(
                color: Colors.amber,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "https://static.vecteezy.com/system/resources/thumbnails/023/056/329/small_2x/programmer-people-working-laptops-or-smartphones-with-ai-artificial-intelligence-software-engineer-coding-on-laptop-computers-with-technology-icons-and-binary-code-big-data-ai-bot-digital-machine-photo.jpg"))),
          ),
          Positioned(
            top: 55,
            left: 140,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: FileImage(File(student.profileImg)),
                ),
                Text(
                  student.fullName,
                  style: GoogleFonts.getFont(
                    "Lato",
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
                Text(
                  student.email,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
