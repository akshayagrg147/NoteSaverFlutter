import 'package:cardsaver/notesave/noteScreen.dart';
import 'package:cardsaver/notesave/notes_modal.dart';
import 'package:flutter/material.dart';
import 'package:cardsaver/splash_page.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory=await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(NotesModalAdapter());
  await Hive.openBox<NotesModal>("notes");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: NoteScreen(),
    );
  }
}

