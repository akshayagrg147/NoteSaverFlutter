import 'package:hive/hive.dart';
import '../../notesfile/constant.dart';
import '../../notesfile/note_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());

  List<NoteModel>? notes;
  fetchAllNotes() {
    var notesBox = Hive.box<NoteModel>(kNotesBox);

    notes = notesBox.values.toList();
    emit(NotesSuccess());
  }

  // List<NotesModal>? note;
  // fetchAllNote() {
  //   var noteBox = Hive.box<NotesModal>(kNotesBox);
  //
  //   note = noteBox.values.toList();
  //   emit(NotesSuccess());
  // }
}
