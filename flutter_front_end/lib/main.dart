import 'package:flutter/material.dart';
import 'package:flutter_front_end/screen/student_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School Pickup',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const StudentScreen(),
    );
  }
}
