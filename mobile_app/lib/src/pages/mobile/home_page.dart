import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_app/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var settings = Hive.box('generalSettings');
    return Scaffold(
      body: Stack(
        children: [
          _homeGradient,
          Positioned.fill(
              bottom: MediaQuery.of(context).size.height * 7 / 12,
              child: Align(
                  alignment: Alignment.center,
                  child: _schoolName(name: settings.get('schoolName')))),
          Positioned.fill(
              bottom: MediaQuery.of(context).size.height * 3 / 12,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "School Pickup",
                  style: CustomTextStyle.homePageGeneral(),
                ),
              )),
          Positioned.fill(
              bottom: MediaQuery.of(context).size.height * 1 / 12,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "As part of",
                  style: CustomTextStyle.homePageGeneralSmall(),
                ),
              )),
          Positioned.fill(
              top: MediaQuery.of(context).size.height * 1 / 12,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Smart City",
                  style: CustomTextStyle.homePageGeneral(),
                ),
              )),
          _homeLogin(context),
        ],
      ),
    );
  }

  Widget _schoolName({String? name}) {
    if (name == null) {
      return SafeArea(
        child: Stack(
          children: [
            const Text(
              "  from",
              style: TextStyle(color: Colors.white),
            ),
            Text(
              "KMITL",
              style: CustomTextStyle.homePageSchoolName(
                  const Color.fromARGB(255, 255, 153, 0)),
            ),
            Text(
              "I",
              style: CustomTextStyle.homePageSchoolName(
                  const Color.fromARGB(255, 223, 63, 0)),
            )
          ],
        ),
      );
    }
    return SafeArea(
      child: Stack(
        children: [
          Text(
            name,
            style: CustomTextStyle.homePageSchoolName(
                const Color.fromARGB(255, 255, 153, 0)),
          ),
          if (isFirstLetterVertical(name[0]))
            Text(
              "I",
              style: CustomTextStyle.homePageSchoolName(
                  const Color.fromARGB(255, 223, 63, 0)),
            )
        ],
      ),
    );
  }

  Widget get _homeGradient => Container(
        // Add box decoration
        decoration: BoxDecoration(
          // Box decoration takes a gradient
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            // Add one stop for each color. Stops should increase from 0 to 1
            stops: [0.2, 0.3, 0.5, 0.8], //[0.1, 0.5, 0.7, 0.9],
            colors: [
              // Colors are easy thanks to Flutter's Colors class.
              Colors.indigo[900]!,
              Colors.indigo[800]!,
              Colors.indigo[600]!,
              Colors.indigo[300]!,
            ],
          ),
        ),
      );

  Widget _homeLogin(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      //mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(screenW / 10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 15,
                  //offset: Offset(0, 0), // changes position of shadow
                ),
              ]),
          width: screenW,
          height: (screenH / 5) + 20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ButtonStyle(elevation: MaterialStateProperty.all(6)),
                  onPressed: () {
                    Navigator.of(context).push(_routeBringLogin());
                  },
                  child: SizedBox(
                    width: screenW / 1.5,
                    child: Text(
                      "Get Started",
                      textAlign: TextAlign.center,
                      style: CustomTextStyle.display3(),
                    ),
                  )),
              TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) => _showHelpAlert(context),
                        barrierDismissible: true);
                  },
                  child: Container(child: Text("Help")))
            ],
          ),
        ),
      ],
    );
  }

  AlertDialog _showHelpAlert(BuildContext context) {
    return AlertDialog(
      title: Text("📣"),
      content: const Text(
          "Please contact your school administrator to get the required information in order to start using this application."),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Dismiss")),
      ],
    );
  }

  Route _routeBringLogin() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const HomePageLogin(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset(0.0, 0.0);
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}

class HomePageLogin extends StatefulWidget {
  const HomePageLogin({super.key});

  @override
  State<HomePageLogin> createState() => _HomePageLoginState();
}

class _HomePageLoginState extends State<HomePageLogin> {
  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading:
            Container(), //IconButton(icon: Icon(Icons.arrow_drop_down), onPressed: () {}),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios_new))
        ],
      ),
      body: SizedBox(
        width: screenW,
        height: screenH,
        child: Column(
          children: [
            //Text("Authentication Method selector"),
            LoginChoice(),
          ],
        ),
      ),
    );
  }
}

enum LoginMethods { userpass, qrcode, something }

class LoginChoice extends StatefulWidget {
  const LoginChoice({super.key});

  @override
  State<LoginChoice> createState() => _LoginChoiceState();
}

class _LoginChoiceState extends State<LoginChoice> {
  LoginMethods selection = LoginMethods.userpass;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<LoginMethods>(
      showSelectedIcon: false,
      segments: <ButtonSegment<LoginMethods>>[
        ButtonSegment<LoginMethods>(
            value: LoginMethods.userpass,
            label: Text('Username', style: CustomTextStyle.selector),
            icon: Icon(Icons.badge_rounded)),
        ButtonSegment<LoginMethods>(
          value: LoginMethods.qrcode,
          label: Text('QR Code', style: CustomTextStyle.selector),
          icon: const Icon(Icons.qr_code_scanner_rounded),
        ),
        // ButtonSegment<LoginMethods>(
        //     value: LoginMethods.something, label: Text('M')),
      ],
      selected: <LoginMethods>{selection},
      onSelectionChanged: (Set<LoginMethods> newSelection) {
        setState(() {
          selection = newSelection.first;
        });
      },
      //multiSelectionEnabled: true,
    );
  }
}

bool isFirstLetterVertical(String firstLetter) {
  const verticalLettersOfNunitoFont = {
    'B',
    'D',
    'E',
    'F',
    'H',
    'I',
    'K',
    'L',
    'M',
    'N',
    'P',
    'R'
  };

  if (verticalLettersOfNunitoFont.contains(firstLetter)) return true;
  return false;
}
