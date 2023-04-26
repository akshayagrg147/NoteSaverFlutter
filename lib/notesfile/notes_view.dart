import 'package:cardsaver/notesfile/add_note_bottom_sheet.dart';
import 'package:cardsaver/notesfile/notes_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class NotesView extends StatelessWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFf4f4f4),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Color(0xFFFff6f1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              context: context,
              builder: (context) {
                return const AddNoteBottomSheet();
                // return const Text("ABC");
              });
        },
        child: const Icon(Icons.add),
      ),
      body: const NotesViewBody(),
      // body: const Text("ABC"),
    );
  }
}


