
import 'package:cardsaver/notesave/notes_modal.dart';
import 'package:hive/hive.dart';

class Boxes{
  static Box<NotesModal> getdata()=>Hive.box<NotesModal>("notes");
  static Box<SocialModal> getSocialPasswords()=>Hive.box<SocialModal>("socialPasswords");
  static Box<CategoryModal> getCategoryModal()=>Hive.box<CategoryModal>("category");
}

