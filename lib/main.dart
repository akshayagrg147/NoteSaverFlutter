//homepage.dart, credit card page
// line 39-51
// name for account name
//SearchField.dart,chart.dart
//icon for passwords
//name for account and edit function or not
import 'package:cardsaver/notesave/notes_modal.dart';
import 'package:cardsaver/notesfile/note_model.dart';
import 'package:cardsaver/notesfile/simple_bloc_observer.dart';
import 'package:cardsaver/notesfile/notes_cubit.dart';
import 'package:cardsaver/ui/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:cardsaver/notesfile/constant.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(NotesModalAdapter());
  Hive.registerAdapter(SocialModalAdapter());
  await Hive.openBox<NotesModal>("notes");
  await Hive.openBox<SocialModal>("socialPasswords");
  await Hive.openBox<SocialModal>("facebookPasswords");
  await Hive.openBox<SocialModal>("instagramPasswords");
  await Hive.openBox<SocialModal>("googlePasswords");

  await Hive.initFlutter();
  Bloc.observer = SimpleBlocObserver();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>(kNotesBox);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: const Splash(),
        // home: MyHomePage(title: 'hello',),
      ),
    );
  }
}
