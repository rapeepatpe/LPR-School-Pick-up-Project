import 'package:flutter/material.dart';
import 'package:flutter_front_end/screen/student_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  ensureI

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School Pickup',
      theme: ThemeData(
        fontFamily: GoogleFonts.nunito().fontFamily,
        primarySwatch: Colors.blueGrey,
      ),
      home: const StudentScreen(),
    );
  }
}
