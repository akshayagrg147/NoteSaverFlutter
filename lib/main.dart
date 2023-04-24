
import 'package:cardsaver/notesave/notes_modal.dart';
import 'package:cardsaver/notesfile/add_note_cubit.dart';
import 'package:cardsaver/notesfile/note_model.dart';
import 'package:cardsaver/notesfile/simple_bloc_observer.dart';
import 'package:cardsaver/notesfile/notes_cubit.dart';

import 'package:cardsaver/ui/homepage.dart';
import 'package:cardsaver/ui/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cardsaver/notesfile/constant.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


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
  await Hive.openBox<SocialModal>("facebookPasswords");
  await Hive.openBox<SocialModal>("instagramPasswords");
  await Hive.openBox<SocialModal>("googlePasswords");

  await Hive.initFlutter();
  Bloc.observer = SimpleBlocObserver();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>(kNotesBox);


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
    return BlocProvider(
      create: (context) => NotesCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: Splash(),
        // home: MyHomePage(title: 'hello',),

      ),
    );
  }
}

