
import 'package:cardsaver/notesave/notes_modal.dart';
import 'package:cardsaver/ui/homepage.dart';
import 'package:cardsaver/ui/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory=await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(NotesModalAdapter());
  Hive.registerAdapter(SocialModalAdapter());
  Hive.registerAdapter(CategoryModalAdapter());
  final record1=await Hive.openBox<NotesModal>("notes");
  final record2=await Hive.openBox<SocialModal>("socialPasswords");
  final record3=await Hive.openBox<CategoryModal>("category");
  final record4=await Hive.openBox<SocialModal>("facebookPasswords");
  final record5= await Hive.openBox<SocialModal>("instagramPasswords");
  final count1 = record1.keys.length;
  final count2 = record2.keys.length;
  final count3 = record3.keys.length;
  final count4 = record4.keys.length;
  final count5 = record5.keys.length;

  // _openBox();

  runApp(MyApp());
}
List<Box> boxList = [];
Future<List<Box>> _openBox() async {
  var directory=await getApplicationDocumentsDirectory();
  Hive
    ..init(directory.path)
    ..registerAdapter(NotesModalAdapter())
    ..registerAdapter(SocialModalAdapter())
    ..registerAdapter(CategoryModalAdapter());

  // var box_session = await Hive.openBox("notes");
  var box_comment =await Hive.openBox("socialPasswords");
  //boxList.add(box_session);
  boxList.add(box_comment);
  return boxList;
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Splash(),
      // home: MyHomePage(title: 'hello',),

    );
  }
}

