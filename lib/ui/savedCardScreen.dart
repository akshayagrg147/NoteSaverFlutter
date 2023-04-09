
import 'package:cardsaver/notesave/boxes.dart';
import 'package:cardsaver/notesave/notes_modal.dart';
import 'package:cardsaver/ui/creditCardPage.dart';
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
    child: Row(
      children: [
        Icon(Icons.add_card),
        Container(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Card Number  : ${data[index].cardnumber.toString()}"),
            Text("Holder name   : ${data[index].cardholder.toString()}"),
            Text("Expiry               : ${data[index].expiry.toString()}"),
            Text("Cvv                   : ${data[index].cvv.toString()}")
          ],
        ),
      ],
    ),
  );
}
); }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  CreditCardPage()),
          );

        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
