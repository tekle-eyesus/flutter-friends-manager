import 'package:flutter/material.dart';

class StudentDetail extends StatelessWidget {
  final Map<dynamic, dynamic> student;
  final int index;
  const StudentDetail({super.key, required this.student, required this.index});

  @override
  Widget build(BuildContext context) {
    print(student);
    print(index);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        title: const Text("Student Detail"),
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
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 55,
                  backgroundImage: NetworkImage(
                      "https://media.istockphoto.com/id/1438969575/photo/smiling-young-male-college-student-wearing-headphones-standing-in-a-classroom.jpg?b=1&s=612x612&w=0&k=20&c=4QffcxGza_rr--wWMoe4up9EOJ_rhG4EPYcH5Is-Mv0="),
                ),
                Text(
                  student["name"],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    color: Colors.blue.shade900,
                  ),
                ),
                Text(
                  student["department"],
                  style: TextStyle(
                    color: Colors.blue.shade800,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                _planBuilder(student['plan']),
              ],
            ),
          ),

          // _imageBuilder(),
        ],
      ),
    );
  }

  Widget _imageBuilder() {
    return Container(
      child: Image.network(
        "https://media.istockphoto.com/id/1438969575/photo/smiling-young-male-college-student-wearing-headphones-standing-in-a-classroom.jpg?b=1&s=612x612&w=0&k=20&c=4QffcxGza_rr--wWMoe4up9EOJ_rhG4EPYcH5Is-Mv0=",
        height: 300,
      ),
    );
  }

  Widget _planBuilder(String plan) {
    return Container(
      width: 340,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade400,
      ),
      child: Text(
          style: const TextStyle(
            fontSize: 20,
            fontStyle: FontStyle.italic,
          ),
          "\"${plan}\""),
    );
  }
}
