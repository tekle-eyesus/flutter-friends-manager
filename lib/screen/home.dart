import 'dart:io';
import 'package:class_1/box/student_box.dart';
import 'package:class_1/controllers/box_controller.dart';
import 'package:class_1/model/student.dart';
import 'package:class_1/screen/add_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
      backgroundColor: Colors.blue,
      floatingActionButton: FloatingActionButton(
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
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text(
          'Plan of the class mates',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
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
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: _getProfileImage(student.profileImg),
                ),
                title: (Text(student.fullName)),
                subtitle: Text(student.email),
              ),
            );
          },
        );
      },
    );
  }
}
