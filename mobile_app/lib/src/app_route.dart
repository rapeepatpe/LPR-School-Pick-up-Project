import 'package:flutter/material.dart';
import 'package:mobile_app/src/pages/mobile/home_page.dart';

class AppRoute {
  static const home = 'home';
  static const login = 'home/login';

  final _route = <String, WidgetBuilder>{
    home: (context) => const HomePage(),
    login: (context) => const HomePageLogin(),
  };

  get getAll => _route;
}
