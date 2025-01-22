import 'dart:io';
import 'dart:math';

import 'package:class_1/helper/helper_fun.dart';
import 'package:class_1/model/student.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentDetail extends StatelessWidget {
  final Student student;

  const StudentDetail({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    var intValue = Random().nextInt(7);
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
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.purple)),
              onPressed: () {
                showEditDialog(context, student);
              },
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
                decoration: BoxDecoration(
                  color: Colors.blue.shade400,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/image/${intValue + 1}.jpg'),
                  ),
                ),
              ),
              Positioned(
                top: 55,
                left: 140,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 70,
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
            height: 160,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 180,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    gradient: LinearGradient(
                      colors: [
                        Colors.grey.shade100,
                        Colors.grey.shade200,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        offset: const Offset(0.8, 0.4),
                        blurRadius: 2,
                      )
                    ]),
                child: Expanded(
                  child: ListTile(
                    leading: Image.asset(
                      "assets/icons/birthday.png",
                      width: 30,
                      height: 30,
                    ),
                    title: Text(
                      "BIRTHDAY",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      getDate(student.dop),
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w400,
                        fontSize: 17.6,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    gradient: LinearGradient(
                      colors: [
                        Colors.grey.shade100,
                        Colors.grey.shade200,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        offset: const Offset(0.8, 0.4),
                        blurRadius: 2,
                      )
                    ]),
                child: Expanded(
                  child: ListTile(
                    leading: Image.asset(
                      "assets/icons/dept.png",
                      width: 30,
                      height: 30,
                    ),
                    title: Text(
                      "DEPARTMENT",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      student.department.split(" ")[0],
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w400,
                        fontSize: 17.6,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                colors: [
                  Colors.grey.shade100,
                  Colors.grey.shade200,
                ],
              ),
            ),
            child: ListTile(
              leading: Image.asset(
                "assets/icons/phone.png",
                width: 34,
                height: 34,
              ),
              title: Text(
                "PHONE",
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                student.phone,
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w400,
                  fontSize: 17.6,
                ),
              ),
              trailing: GestureDetector(
                onTap: () async {
                  final Uri url = Uri(scheme: 'tel', path: student.phone);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    print("can not lounch this URL !!");
                  }
                },
                child: Image.asset(
                  "assets/icons/phoned.png",
                  width: 36,
                  height: 36,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                colors: [
                  Colors.grey.shade100,
                  Colors.grey.shade200,
                ],
              ),
            ),
            child: ExpansionTile(
              shape: const Border(),
              title: Text(
                "PLAN",
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Image.asset(
                "assets/icons/plan.png",
                width: 32,
                height: 32,
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 360,
                        child: Text(
                          student.plan,
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
