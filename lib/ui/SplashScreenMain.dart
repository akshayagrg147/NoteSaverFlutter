import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cardsaver/ui/homepage.dart';


class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const MyHomePage(title: 'hello',),
      ));
    });

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        color: Colors.orange,
        child: const Center(
          child:
          Text("CARD SAVER",style: TextStyle(
            fontSize: 34,fontWeight:FontWeight.bold,
            color: Colors.white,

          ),),
        ),
      ),
    );
  }
}