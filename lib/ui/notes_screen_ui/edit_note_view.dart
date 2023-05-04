import 'package:flutter/material.dart';
import '../../models/note_model.dart';
import 'edit_view_body.dart';

class EditNoteView extends StatelessWidget {
  const EditNoteView({Key? key, required this.note}) : super(key: key);

  final NoteModel note;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFff6f1),
      body: EditNoteViewBody(
        note: note,
      ),
    );
  }
}
