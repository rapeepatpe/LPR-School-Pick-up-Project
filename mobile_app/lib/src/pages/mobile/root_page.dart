import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

/**
 * Landing page for route '/'
 * check if initalized
 * yes -> /home
 * no -> /login
 */

class _RootPageState extends State<RootPage> {
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    var hSettings = Hive.box('generalSettings');
    if (hSettings.get('initalized') == false) {
      // not initalized
    }
    if (hSettings.get('loggedIn') == false) {
      // not logged in
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
