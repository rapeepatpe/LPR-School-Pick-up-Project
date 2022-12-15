import 'package:demo/api/notification_api.dart';
import 'package:flutter/material.dart';
import 'comingpage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotiPage extends StatefulWidget {
  const NotiPage({super.key});

  @override
  State<NotiPage> createState() => _NotiPageState();
}

class _NotiPageState extends State<NotiPage> {
  bool isTime = false;

  @override
  void initState() {
    super.initState();

    NotificationApi.init();
    listenNotifications();
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) =>
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ComingPage(payload: payload),
      ));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Noti Page"),
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
                    child: Icon(
                      isTime ? Icons.notifications : Icons.watch_later_rounded,
                      size: 100.0,
                    ), //Image.asset('asset/images/flutter-logo.png'),
                  ),
                ),
              ),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  isTime
                      ? "Your parent is on their way"
                      : "Please wait for school to end",
                  style: TextStyle(
                      fontSize: isTime ? 30.0 : 25.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  isTime
                      ? "we'll notify you right away when we spot them"
                      : "it's not the pickup time yet",
                  style: const TextStyle(fontSize: 16.0),
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
                  onPressed: isTime
                      ? () {
                          // TODO: SEND NOTIFICATION
                          // NotificationApi.showNotification(
                          //   title: "Your parent is at IT faculty gate.",
                          //   body:
                          //       "The car number is \"กข 6432\" and they are verified to be your parent.",
                          //   payload: '~5mins',
                          // );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      const ComingPage(payload: "test")));
                        }
                      : () {
                          setState(() {
                            isTime = true;
                          });
                        },
                  child: Text(
                    isTime ? 'Test Notification' : 'skip to school end time',
                    style: TextStyle(
                        color: Colors.white, fontSize: isTime ? 25 : 20),
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
