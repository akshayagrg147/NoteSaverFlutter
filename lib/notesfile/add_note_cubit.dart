import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';
import '../../notesfile/constant.dart';
import '../../notesfile/note_model.dart';
import 'package:cardsaver/notesave/notes_modal.dart';
part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit() : super(AddNoteInitial());

  Color color = const Color(0xffAC3931);

  addNote(NoteModel note) async {
    note.color = color.value;
    emit(AddNoteLoading());
    try {
      var notesBox = Hive.box<NoteModel>(kNotesBox);
      await notesBox.add(note);
      emit(AddNoteSuccess());
    } catch (e) {
      emit(AddNoteFailure(e.toString()));
    }
  }

  // addColor(NotesModal note) async {
  //   note.selectedcolor = color.value;
  //   emit(AddNoteLoading());
  //   try {
  //     var noteBox = Hive.box<NotesModal>(kNoteBox);
  //     await noteBox.add(note);
  //     emit(AddNoteSuccess());
  //   } catch (e) {
  //     emit(AddNoteFailure(e.toString()));
  //   }
  // }


}
