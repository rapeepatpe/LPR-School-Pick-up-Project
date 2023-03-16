import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PushNotificationExample extends StatefulWidget {
  @override
  _PushNotificationExampleState createState() =>
      _PushNotificationExampleState();
}

class _PushNotificationExampleState extends State<PushNotificationExample> {
  late final FirebaseMessaging _messaging;
  final TextEditingController _topicController = TextEditingController();
  String? _token;

  @override
  void initState() {
    super.initState();
    _messaging = FirebaseMessaging.instance;
    _requestPermissionAndToken();
    _configureForegroundMessageHandler();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    if (kIsWeb) {
      Future<void> _firebaseMessagingBackgroundHandler(
          RemoteMessage message) async {
        // If you're going to use other Firebase services in the background, such as Firestore,
        // make sure you call `initializeApp` before using other Firebase services.
        await Firebase.initializeApp();

        print("Handling a background message: ${message.messageId}");
      }
    }
  }

  Future<void> _requestPermissionAndToken() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await _messaging.getToken();
      setState(() {
        _token = token;
      });
    }
  }

  void _configureForegroundMessageHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(notification.title ?? ''),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [Text(notification.body ?? '')],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Firebase Token:'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SelectableText(_token ?? ''),
          ),
          SizedBox(height: 16),
          TextField(
            controller: _topicController,
            decoration: InputDecoration(
              labelText: 'Topic',
              hintText: 'Enter a topic to subscribe',
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await _messaging.subscribeToTopic(_topicController.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Subscribed to ${_topicController.text}'),
                    ),
                  );
                },
                child: Text('Subscribe'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await _messaging.unsubscribeFromTopic(_topicController.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Unsubscribed from ${_topicController.text}'),
                    ),
                  );
                },
                child: Text('Unsubscribe'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
