import 'package:cardsaver/models/notes_modal.dart';
import 'package:cardsaver/models/note_model.dart';
import 'package:cardsaver/providers/simple_bloc_observer.dart';
import 'package:cardsaver/providers/notes_cubit.dart';
import 'package:cardsaver/ui/splash_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cardsaver/constants/notes_constant.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb &&
      kDebugMode &&
      defaultTargetPlatform == TargetPlatform.android) {
    await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
  }

  var directory = await getApplicationDocumentsDirectory();
   Hive.init(directory.path);
  Hive.registerAdapter(NotesModalAdapter());
  Hive.registerAdapter(SocialModalAdapter());
  Hive.registerAdapter(ProfileInfoModelAdapter());
  Hive.registerAdapter(DocumentModalAdapter());
  Hive.registerAdapter(TransactionModalAdapter());

  await Future.wait([
    Hive.openBox<NotesModal>("notes"),
    Hive.openBox<SocialModal>("socialPasswords"),
    Hive.openBox<SocialModal>("facebookPasswords"),
    Hive.openBox<SocialModal>("instagramPasswords"),
    Hive.openBox<SocialModal>("googlePasswords"),
    Hive.openBox<SocialModal>("internetBanking"),
    Hive.openBox<ProfileInfoModal>("profileinfo"),
    Hive.openBox<DocumentModal>("pan"),
    Hive.openBox<DocumentModal>("aadhaar"),
    Hive.openBox<DocumentModal>("license"),
    Hive.openBox<DocumentModal>("ssc"),
    Hive.openBox<DocumentModal>("hsc"),
    Hive.openBox<DocumentModal>("other"),
    Hive.openBox<TransactionModal>("Add"),
    Hive.initFlutter(),
  ]);

  Bloc.observer = SimpleBlocObserver();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>(kNotesBox);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesCubit(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: ThemeData.dark(),
        home: Splash(),
        // home: MyHomePage(title: 'hello',),
      ),
    );
  }
}
