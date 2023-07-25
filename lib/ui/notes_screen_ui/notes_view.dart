// import 'package:cardsaver/Utils/notes_widgets/add_note_bottom_sheet.dart';
// import 'package:cardsaver/ui/notes_screen_ui/notes_view_body.dart';
// import 'package:flutter/material.dart';
//
// class NotesView extends StatelessWidget {
//   const NotesView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: const Color(0xFFf4f4f4),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showModalBottomSheet(
//               isScrollControlled: true,
//               backgroundColor: const Color(0xFFFff6f1),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               context: context,
//               builder: (context) {
//                 return const AddNoteBottomSheet(navigator:"just_pop");
//                 // return const Text("ABC");
//               });
//         },
//         child: const Icon(Icons.add),
//       ),
//       body: const NotesViewBody(),
//       // body: const Text("ABC"),
//     );
//   }
// }
//
//
