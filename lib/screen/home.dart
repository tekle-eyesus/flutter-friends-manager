import 'dart:io';
import 'package:class_1/box/student_box.dart';
import 'package:class_1/controllers/box_controller.dart';
import 'package:class_1/helper/helper_fun.dart';
import 'package:class_1/model/student.dart';
import 'package:class_1/screen/add_screen.dart';
import 'package:class_1/screen/student_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:slideable/slideable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 72, 133),
      appBar: AppBar(
        title: Text(
          "MyFriends",
          style: GoogleFonts.pacifico(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade300,
              fontSize: 25,
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const AddScreen();
                  },
                ),
              );
            },
            icon: Icon(
              Icons.add_circle,
              size: 35,
              color: Colors.grey.shade200,
            ),
          ),
        ],
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 222, 238, 252),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10),
            ),
          ),
          child: _buildListTitle()),
    );
  }

  Widget _buildListTitle() {
    BoxServices boxServices = BoxServices();
    ImageProvider<Object> _getProfileImage(String? imagePath) {
      if (imagePath != null && imagePath.isNotEmpty) {
        return FileImage(File(imagePath));
      } else {
        return const AssetImage('assets/image/user.png'); // Fallback image
      }
    }

    String upperCaseName(String name) {
      return name[0].toUpperCase() + name.substring(1);
    }

    return ValueListenableBuilder(
      valueListenable: studentBox.listenable(),
      builder: (context, box, widget) {
        if (box.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/image/empty.png",
                  height: 300,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "No  Classmate Added",
                  style: GoogleFonts.getFont(
                    "Lato",
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                )
              ],
            ),
          );
        }
        return ListView.builder(
          itemCount: studentBox.length,
          itemBuilder: (context, index) {
            Student student = studentBox.getAt(index);

            return Slideable(
              //  resetSlide: resetSlide,
              items: <ActionItems>[
                ActionItems(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 30,
                  ),
                  onPress: () {
                    boxServices.deleteStudent(index, context);
                  },
                  backgroudColor: Colors.transparent,
                ),
              ],
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return StudentDetail(
                      student: student,
                    );
                  }));
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade100,
                  ),
                  child: ListTile(
                    isThreeLine: true,
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: _getProfileImage(student.profileImg),
                    ),
                    title: Text(
                      upperCaseName(student.fullName),
                      style: GoogleFonts.overpass(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "Email: ",
                                style: GoogleFonts.getFont(
                                  "Lato",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.grey.shade700,
                                )),
                            TextSpan(
                              text: student.email,
                              style: GoogleFonts.getFont(
                                "Lato",
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            )
                          ]),
                        ),
                        Row(
                          children: [
                            Text(
                              student.department,
                              style: GoogleFonts.getFont(
                                "Lato",
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                              child: Text(
                                " | ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              getDate(student.dop),
                              style: GoogleFonts.getFont(
                                "Lato",
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
