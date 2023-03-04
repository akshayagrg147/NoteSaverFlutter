import 'package:cardsaver/notesave/boxes.dart';
import 'package:cardsaver/notesave/notes_modal.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final cardnumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Card Notes"),
      ),
      body: ValueListenableBuilder<Box<NotesModal>>(
        valueListenable: Boxes.getdata().listenable(),
        builder: (context,box,_){
          var data=box.values.toList().cast<NotesModal>();
return ListView.builder(
  itemCount: box.length,
    itemBuilder: (context,index){
  return Card(
    child: Column(
      children: [
        Text(data[index].title.toString())
      ],
    ),
  );
}
); }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final data = NotesModal(title: "skks", description: "sjssjj");
          final box = Boxes.getdata();
          box.add(data);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
