import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_app/src/app_route.dart';
import 'package:mobile_app/src/bloc/app_bloc_observer.dart';
import 'package:mobile_app/src/pages/mobile/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await Hive.initFlutter();
  var settings = await Hive.openBox('generalSettings');
  //print(settings.get('noPutYet')); --> null
  if (settings.get('initialize') == null) {
    //not initialized yet
    settings.put('initialize', false);
  }
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: AppRoute().getAll,
      title: 'Smart City School Pickup',
      theme: ThemeData(
        fontFamily: GoogleFonts.nunito().fontFamily,
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}

class CustomTextStyle {
  static TextStyle homePageSchoolName(Color? color) => TextStyle(
        fontSize: 90,
        color: color,
        fontWeight: FontWeight.w900,
        fontFamily: GoogleFonts.nunito().fontFamily,
      );

  static TextStyle homePageGeneral() => const TextStyle(
        fontSize: 35,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      );

  static TextStyle homePageGeneralSmall() => const TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      );

  static TextStyle display3() => const TextStyle(
        fontSize: 15,
      );

  static TextStyle get selector =>
      const TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
}
