import 'package:flutter/material.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});
  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          ),
          title: const Text("Student Page"),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: _menuBuilder(),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "เวลาที่จะถึงโดยประมาณ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _menuBuilder() {
    return [
      const DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.blueGrey,
        ),
        child: Text(
          'Guest User',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      ListTile(
        leading: const Icon(Icons.notifications),
        title: const Text('Notify'),
        onTap: () {},
      ),
      ListTile(
        leading: const Icon(Icons.settings),
        title: const Text('Setting'),
        onTap: () {},
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: MaterialButton(
          color: Colors.red,
          elevation: 8.0,
          highlightElevation: 2.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          textColor: Colors.white,
          onPressed: () {},
          child: const Text('log out'),
        ),
      )
    ];
  }
}
