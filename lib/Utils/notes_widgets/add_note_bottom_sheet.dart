// import 'package:cardsaver/ui/notes_screen_ui/notes_view.dart';
// import   'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../providers/add_note_cubit.dart';
// import '../../providers/notes_cubit.dart';
// import 'add_note_form.dart';
//
// class AddNoteBottomSheet extends StatelessWidget {
//   final String navigator;
//   const AddNoteBottomSheet({Key? key, required this.navigator}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       BlocProvider(
//       create: (context) => AddNoteCubit(),
//       child:
//       BlocConsumer<AddNoteCubit, AddNoteState>(
//         listener: (context, state) {
//           if (state is AddNoteFailure) {}
//
//           if (state is AddNoteSuccess) {
//             BlocProvider.of<NotesCubit>(context).fetchAllNotes();
//             if(navigator == "tonotespage"){
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const NotesView()),
//               );
//             }
//             else if(navigator == "just_pop"){
//               Navigator.pop(context);
//             }
//           }
//         },
//         builder: (context, state) {
//           return AbsorbPointer(
//             absorbing: state is AddNoteLoading ? true : false,
//             child: Padding(
//               padding: EdgeInsets.only(
//                   left: 16,
//                   right: 16,
//                   bottom: MediaQuery.of(context).viewInsets.bottom),
//               child: const SingleChildScrollView(
//                 child: AddNoteForm(),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
