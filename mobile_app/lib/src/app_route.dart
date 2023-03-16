import 'package:flutter/material.dart';
import 'package:mobile_app/src/pages/mobile/home_page.dart';
import 'package:mobile_app/src/pages/mobile/root_page.dart';

class AppRoute {
  static const root = '/';
  static const home = 'home';
  static const login = 'home/login';

  final _route = <String, WidgetBuilder>{
    //root: (context) => const RootPage(),
    home: (context) => const HomePage(),
    login: (context) => const HomePageLogin(),
  };

  get getAll => _route;
}
