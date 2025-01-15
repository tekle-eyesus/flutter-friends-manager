import 'package:class_1/box/student_box.dart';
import 'package:class_1/model/student.dart';
import 'package:class_1/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final documentDirectory = await getApplicationDocumentsDirectory();
  // Hive.init(documentDirectory.path);
  await Hive.initFlutter();
  Hive.registerAdapter(StudentAdapter());
  studentBox = await Hive.openBox<Student>('studentBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
