import 'package:flutter/material.dart';

class ArrivePage extends StatefulWidget {
  const ArrivePage({super.key});

  @override
  State<ArrivePage> createState() => _ArrivePageState();
}

class _ArrivePageState extends State<ArrivePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Arrived Page"),
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
                      color: Colors.green,
                      size: 100.0,
                    ), //Image.asset('asset/images/flutter-logo.png'),
                  ),
                ),
              ),
              const Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Your parent is arrived at the school.",
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
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
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 130,
              ),
              Container(
                  // height: 50,
                  // width: 250,
                  // decoration: BoxDecoration(
                  //     color: Colors.blue,
                  //     borderRadius: BorderRadius.circular(20)),
                  // child: TextButton(
                  //   onPressed: () {
                  //     // TODO: NOTIFY HERE WHEN ARRIVED
                  //     // Navigator.push(context,
                  //     //     MaterialPageRoute(builder: (_) => const ArrivePage()));
                  //   },
                  //   child: const Text(
                  //     'Arrived',
                  //     style: TextStyle(color: Colors.white, fontSize: 25),
                  //   ),
                  // ),
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
