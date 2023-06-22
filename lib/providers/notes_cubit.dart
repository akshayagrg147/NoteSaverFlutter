import 'package:hive/hive.dart';
import '../constants/notes_constant.dart';
import '../models/note_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());

  List<NoteModel>? notes1;
  fetchAllNotes() {
    var notesBox = Hive.box<NoteModel>(kNotesBox);

    notes1 = notesBox.values.toList();
    emit(NotesSuccess(notes1));
  }

  // List<NotesModal>? note;
  // fetchAllNote() {
  //   var noteBox = Hive.box<NotesModal>(kNotesBox);
  //
  //   note = noteBox.values.toList();
  //   emit(NotesSuccess());
  // }
}
