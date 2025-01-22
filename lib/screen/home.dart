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

    return ValueListenableBuilder(
      valueListenable: studentBox.listenable(),
      builder: (context, box, widget) {
        if (box.isEmpty) {
          return Center(
            child: Image.asset(
              "assets/image/empty.png",
              height: 300,
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
                    Icons.favorite,
                    color: Colors.blue,
                  ),
                  onPress: () {
                    // add to favorite!!!
                    DisplayMessage(context, "Test Text for!!");
                  },
                  backgroudColor: Colors.transparent,
                ),
                ActionItems(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
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
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.grey.shade100,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(1, 1),
                        color: Colors.grey.shade500,
                        blurRadius: 3,
                      )
                    ],
                  ),
                  child: ListTile(
                    isThreeLine: true,
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: _getProfileImage(student.profileImg),
                    ),
                    title: Text(
                      student.fullName,
                      style: GoogleFonts.overpass(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email: ${student.email}',
                          style: GoogleFonts.getFont(
                            "Lato",
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
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
