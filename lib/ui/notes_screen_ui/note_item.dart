import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../providers/notes_cubit.dart';
import '../../models/note_model.dart';
import 'edit_note_view.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({Key? key, required this.note}) : super(key: key);

  final NoteModel note;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return EditNoteView(
              note: note,
            );
          }),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(note.color),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.only(left: 10, top: 20, bottom: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ListTile(
              title: Text(
                note.title,
                style: const TextStyle(
                  fontSize: 26,
                  color: Colors.black,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  note.subTitle,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black.withOpacity(.7),
                    // color: Colors.black54,
                  ),
                ),
              ),
              trailing: IconButton(
                onPressed: () {
                  note.delete();

                  BlocProvider.of<NotesCubit>(context).fetchAllNotes();
                },
                icon: const Icon(
                  Icons.delete_outlined,
                  color: Colors.black54,
                  size: 30,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                note.date,
                style: const TextStyle(
                  color: Colors.black54,
                  // color: Colors.black.withOpacity(.4),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
