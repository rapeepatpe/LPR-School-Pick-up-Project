import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Icon(Icons.access_alarm),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Widget buildUsername() => Padding(
        padding: EdgeInsets.all(20),
        child: TextFormField(
          controller: usernameController,
        ),
      );

  Widget buildPassword() => Padding(
        padding: EdgeInsets.all(20),
        child: TextFormField(
          controller: passwordController,
        ),
      );
}
