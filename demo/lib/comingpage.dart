import 'package:flutter/material.dart';
import 'arrivepage.dart';

class ComingPage extends StatefulWidget {
  const ComingPage({super.key, required this.payload});
  final String? payload;

  @override
  State<ComingPage> createState() => _ComingPageState();
}

class _ComingPageState extends State<ComingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Notified Page"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: const Icon(
                      Icons.notifications_active,
                      color: Colors.amber,
                      size: 100.0,
                    ), //Image.asset('asset/images/flutter-logo.png'),
                  ),
                ),
              ),
              const Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Your parent is at IT faculty gate.",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "The car number is \"กข 6432\" and",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "they are verified to be your parent.",
                        style: TextStyle(fontSize: 16.0, color: Colors.green),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Estimated Time Arrival is ~ 5 mins",
                        style: TextStyle(fontSize: 16.0, color: Colors.amber),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 130,
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    // TODO: NOTIFY HERE WHEN ARRIVED
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const ArrivePage()));
                  },
                  child: const Text(
                    'Arrived',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              const SizedBox(
                height: 130,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
