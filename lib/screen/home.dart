import 'dart:io';
import 'package:class_1/box/student_box.dart';
import 'package:class_1/controllers/box_controller.dart';
import 'package:class_1/helper/helper_fun.dart';
import 'package:class_1/model/student.dart';
import 'package:class_1/screen/add_screen.dart';
import 'package:class_1/screen/student_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
      backgroundColor: Colors.blue.shade100,
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
              onPressed: () {},
              icon: Icon(
                Icons.search,
                size: 35,
                color: Colors.grey.shade200,
              )),
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
              )),
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: const BorderRadius.vertical(
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

            return Slidable(
              key: const ValueKey(0),
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                dismissible: DismissiblePane(onDismissed: () {}),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      boxServices.deleteStudent(index);
                    },
                    backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                  SlidableAction(
                    onPressed: (context) {},
                    backgroundColor: const Color(0xFF21B7CA),
                    foregroundColor: Colors.white,
                    icon: Icons.share,
                    label: 'Share',
                  ),
                ],
              ),
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
                          offset: Offset(1, 1),
                          color: Colors.grey.shade800,
                          blurRadius: 3,
                        )
                      ]),
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
