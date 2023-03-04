
import 'package:cardsaver/notesave/notes_modal.dart';
import 'package:hive/hive.dart';

class Boxes{
  static Box<NotesModal> getdata()=>Hive.box<NotesModal>("notes");
}