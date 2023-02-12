import 'package:flutter/material.dart';
import 'package:flutter_front_end/screen/student_screen.dart';
import 'package:google_fonts/google_fonts.dart';

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
        fontFamily: GoogleFonts.nunito().fontFamily,
        primarySwatch: Colors.blueGrey,
      ),
      home: const StudentScreen(),
    );
  }
}
