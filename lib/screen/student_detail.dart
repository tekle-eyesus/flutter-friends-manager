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
              colors: <Color>[
                Colors.purple.shade800,
                Colors.blue.shade900,
              ],
            ),
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
      body: Column(
        children: [
          Stack(
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
          const SizedBox(
            height: 130,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.amber,
                ),
                child: Expanded(
                  child: ListTile(
                    leading: Image.asset(
                      "assets/icons/birthday.png",
                      width: 30,
                      height: 30,
                    ),
                    title: Text("BIRTHDAY"),
                    subtitle: Text(student.dop.year.toString()),
                  ),
                ),
              ),
              Container(
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.amber,
                ),
                child: Expanded(
                  child: ListTile(
                    leading: Image.asset(
                      "assets/icons/dept.png",
                      width: 30,
                      height: 30,
                    ),
                    title: const Text("Department"),
                    subtitle: Text(student.department.split(" ")[0]),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              leading: Image.asset(
                "assets/icons/phone.png",
                width: 34,
                height: 34,
              ),
              title: const Text("PHONE"),
              subtitle: Text(student.phone),
              trailing: Image.asset(
                "assets/icons/phoned.png",
                width: 36,
                height: 36,
              ),
            ),
          ),
          ExpansionTile(
            shape: Border(),
            title: Text("PLAN"),
            leading: Image.asset(
              "assets/icons/plan.png",
              width: 32,
              height: 32,
            ),
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 380,
                      child: Text(
                          "noll anawer following follows bolled ba mvnv nmxmx ksks slls sllsowow eieiuw wiwoqwouw qooqowpq wqowqw wqiu ee qeiueq qoqoo"),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
