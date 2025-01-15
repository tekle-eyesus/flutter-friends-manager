import 'package:class_1/box/student_box.dart';
import 'package:class_1/model/student.dart';
import 'package:class_1/screen/add_screen.dart';
import 'package:class_1/screen/student_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Box? _studentBox;

  @override
  void initState() {
    // TODO: implement initState
    Hive.openBox('student').then((box) {
      setState(() {
        _studentBox = box;
      });
    });
    super.initState();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  // TextEditingController imageUrlController = TextEditingController();
  TextEditingController planController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> DispalyDialog(BuildContext context) async {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.blue.shade100,
              title: const Text(
                "Add a new class mate",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: "Enter name",
                      labelText: "Name",
                    ),
                  ),
                  TextField(
                    controller: departmentController,
                    decoration: const InputDecoration(
                      hintText: "Enter department",
                      labelText: "Department",
                    ),
                  ),
                  // TextField(
                  //   decoration: InputDecoration(
                  //     hintText: "Enter the image url of the class mate",
                  //     labelText: "Image Url",
                  //   ),
                  // ),
                  TextField(
                    controller: planController,
                    decoration: const InputDecoration(
                      hintText: "Enter plan",
                      labelText: "Plan",
                    ),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Colors.blue.shade300,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Colors.blue.shade300,
                    ),
                  ),
                  onPressed: () async {
                    if (nameController.text.isEmpty ||
                        departmentController.text.isEmpty ||
                        planController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Enter all Fields!!!"),
                        ),
                      );
                    } else {
                      await _studentBox!.add({
                        'name': nameController.text,
                        'department': departmentController.text,
                        'plan': planController.text,
                      });
                    }

                    Navigator.of(context).pop();
                    nameController.clear();
                    departmentController.clear();
                    planController.clear();
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          });
    }

    return Scaffold(
      backgroundColor: Colors.blue,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // DispalyDialog(context);
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
              )),
          child: _buildListTitle()),
    );
  }

  Widget _buildListTitle() {
    if (studentBox.isEmpty) {
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
        return ListTile(
          title: (Text(student.fullName)),
          subtitle: Text(student.email),
        );
      },
    );
  }

  Widget _buildStudentList() {
    if (studentBox.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      );
    }
    if (_studentBox!.isEmpty) {
      return Center(
        child: Image.asset(
          "assets/image/empty.png",
          height: 300,
        ),
      );
    }

    return ValueListenableBuilder(
        valueListenable: _studentBox!.listenable(),
        builder: (context, box, widget) {
          final studentKeys = _studentBox!.keys.toList();
          return ListView.builder(
              itemCount: studentKeys.length,
              itemBuilder: (context, index) {
                // final student = _studentBox!.getAt(index) as Student;
                Map student = box.get(studentKeys[index]);
                return Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color.fromARGB(255, 229, 241, 250),
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => StudentDetail(
                            student: student,
                            index: studentKeys[index],
                          ),
                        ),
                      );
                    },
                    leading: const CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkVT1tSvNzeBSevPVAQVdRdSvy5EQX5Ko-FQ&s"),
                    ),
                    title: Text(
                      student['name'],
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          student['department'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // Text(
                        //   student['plan'],
                        //   style: const TextStyle(
                        //     fontStyle: FontStyle.italic,
                        //   ),
                        // ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Colors.green.shade200,
                              ),
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.blue.shade100,
                                      title: const Text(
                                        "Edit the student",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                            controller: TextEditingController(
                                                text: student['name']),
                                            decoration: const InputDecoration(
                                              hintText:
                                                  "Enter the name of the class mate",
                                              labelText: "Name",
                                            ),
                                          ),
                                          TextField(
                                            controller: TextEditingController(
                                                text: student['department']),
                                            decoration: const InputDecoration(
                                              hintText:
                                                  "Enter the department of the class mate",
                                              labelText: "Department",
                                            ),
                                          ),
                                          // TextField(
                                          //   decoration: InputDecoration(
                                          //     hintText: "Enter the image url of the class mate",
                                          //     labelText: "Image Url",
                                          //   ),
                                          // ),
                                          TextField(
                                            controller: TextEditingController(
                                                text: student['plan']),
                                            decoration: const InputDecoration(
                                              hintText:
                                                  "Enter the plan of the class mate",
                                              labelText: "Plan",
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.blue.shade300)),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text(
                                            "Cancel",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            // student['plan'] =
                                            //     planController.text;
                                            // student['department'] =
                                            //     departmentController.text;
                                            // student['name'] =
                                            //     nameController.text;
                                            // await _studentBox!.put(
                                            //     studentKeys[index], student);

                                            // Navigator.of(context).pop();
                                            // nameController.clear();
                                            // departmentController.clear();
                                            // planController.clear();
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                            Colors.blue.shade300,
                                          )),
                                          child: const Text(
                                            "Save",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            )),
                        IconButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.red.shade200,
                            ),
                          ),
                          onPressed: () {
                            _studentBox!.delete(studentKeys[index]);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        });
  }
}
