
import 'package:cardsaver/notesave/notes_modal.dart';
import 'package:cardsaver/ui/homepage.dart';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory=await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(NotesModalAdapter());
  Hive.registerAdapter(SocialModalAdapter());
  Hive.registerAdapter(CategoryModalAdapter());
  await Hive.openBox<NotesModal>("notes");
  await Hive.openBox<SocialModal>("socialPasswords");
  await Hive.openBox<CategoryModal>("category");
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
      home: MyHomePage(title: 'hello',),

    );
  }
}

