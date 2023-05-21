import 'dart:async';
import 'package:cardsaver/ui/homepage.dart';
import 'package:cardsaver/ui/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});
  @override
  VideoState createState() => VideoState();
}

class VideoState extends State<Splash> with SingleTickerProviderStateMixin {
  var _visible = true;
  int? isviewed;

  late AnimationController animationController;
  late Animation<double> animation;
  String _packageInfoText = '0';



  startTime() async {
    var sharedpref = await SharedPreferences.getInstance();
    isviewed = sharedpref.getInt('onBoard');
    var duration = const Duration(milliseconds: 1600);
    return Timer(duration, navigationPage);
  }

  void navigationPage() {
    if (isviewed != 0) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const OnBoardingScreen(),
          ));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const MyHomePage(
                    title: 'hello',
                  )));
    }
  }

  void _getInfoPressed() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    // String appName = packageInfo.appName;
    // String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    // String buildNumber = packageInfo.buildNumber;

    setState(() {
      _packageInfoText = "Version: $version";
          
    });
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => setState(() {}));
    animationController.forward();
    setState(() {
      _visible = !_visible;
    });
    startTime();
    _getInfoPressed();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/gif/splash.gif',
                width: animation.value * 250,
                height: animation.value * 250,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_packageInfoText, style: const TextStyle(fontSize: 16,color: Colors.black),),
              )
            ],
          ),
        ],
      ),
    );
  }
}
