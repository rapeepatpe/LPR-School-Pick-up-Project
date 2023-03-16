import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_app/src/app_route.dart';
import 'package:mobile_app/src/bloc/app_bloc_observer.dart';
import 'package:mobile_app/src/pages/mobile/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:mobile_app/src/push_notification_example.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  dotenv.env['VAR_NAME'];
  await Hive.initFlutter();
  var hSettings = await Hive.openBox('generalSettings');
  //print(settings.get('noPutYet')); --> null
  if (hSettings.get('initialize') == null) {
    //not initialized yet
    hSettings.put('initialize', false);
  }
  if (hSettings.get('initialize') == false) {
    //go to login page
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  if (kIsWeb) {
    print('web la');
    String? token = await messaging.getToken(
      vapidKey: dotenv.env['VAR_NAME'],
    );
    if (token != null) {
      print('have fcm web token');
    } else {
      print('token is null');
    }
  }
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  print('after web la');

  print('User granted permission: ${settings.authorizationStatus}');

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
        //initialRoute: '/',
        title: 'Smart City School Pickup',
        theme: ThemeData(
          fontFamily: GoogleFonts.nunito().fontFamily,
          colorSchemeSeed: Colors.indigo,
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: /*const HomePage(),*/ Scaffold(
          appBar: AppBar(
            title: const Text("FCM"),
          ),
          body: PushNotificationExample(),
        ));
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
