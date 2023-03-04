import 'package:flutter/material.dart';
import 'package:cardsaver/splash_page.dart';
import 'package:cardsaver/addpage.dart';
import 'package:cardsaver/homepage.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'hello',),
    );
  }
}

