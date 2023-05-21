import 'package:cardsaver/models/notes_modal.dart';
import 'package:cardsaver/models/note_model.dart';
import 'package:cardsaver/providers/chats_provider.dart';
import 'package:cardsaver/providers/models_provider.dart';
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


  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(NotesModalAdapter());
  Hive.registerAdapter(SocialModalAdapter());
  Hive.registerAdapter(ProfileInfoModelAdapter());
  Hive.registerAdapter(DocumentModalAdapter());
  await Hive.openBox<NotesModal>("notes");
  await Hive.openBox<SocialModal>("socialPasswords");
  await Hive.openBox<SocialModal>("facebookPasswords");
  await Hive.openBox<SocialModal>("instagramPasswords");
  await Hive.openBox<SocialModal>("googlePasswords");
  await Hive.openBox<SocialModal>("internetBanking");
  await Hive.openBox<ProfileInfoModal>("profileinfo");
  await Hive.openBox<DocumentModal>("pan");
  await Hive.openBox<DocumentModal>("aadhaar");
  await Hive.openBox<DocumentModal>("license");
  await Hive.openBox<DocumentModal>("ssc");
  await Hive.openBox<DocumentModal>("hsc");
  await Hive.openBox<DocumentModal>("other");

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ModelsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        )
      ],
      child: BlocProvider(
        create: (context) => NotesCubit(),
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          // theme: ThemeData.dark(),
          home: Splash(),
          // home: MyHomePage(title: 'hello',),
        ),
      ),
    );
  }
}
