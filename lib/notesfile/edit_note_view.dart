import 'package:flutter/material.dart';
import '../../notesfile/note_model.dart';
import '../../notesfile/edit_view_body.dart';

class EditNoteView extends StatelessWidget {
  const EditNoteView({Key? key, required this.note}) : super(key: key);

  final NoteModel note;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFff6f1),
      body: EditNoteViewBody(
        note: note,
      ),
    );
  }
}
