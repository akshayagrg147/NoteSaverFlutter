
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
return Column(
  children: [
    Image.asset(
      'assets/gif/creditcard.gif',
      width: double.infinity,
      height: 250,
    ),
    const SizedBox(
      height: 20,
    ),
Expanded(
child:   ListView.builder(

itemCount: box.length,

    itemBuilder: (context,index){

      return Card(

        color: Colors.white,

        elevation: 5,

        margin: const EdgeInsets.all(5),

        child: Row(

          children: [

            const Icon(Icons.add_card,color: Colors.black,),

            Container(
              width: 10,
            ),

            Column(

              mainAxisAlignment: MainAxisAlignment.start,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text("Card Number  : ${data[index].cardnumber.toString()}",style: const TextStyle(

                  fontSize: 12,

                  color: Colors.black,

                  fontWeight: FontWeight.w700,

                  fontStyle: FontStyle.normal,

                ),),

                Text("Holder name   : ${data[index].cardholder.toString()}",style: const TextStyle(

                  fontSize: 12,

                  color: Colors.black,

                  fontWeight: FontWeight.w700,

                  fontStyle: FontStyle.normal,

                )),

                Text("Expiry               : ${data[index].expiry.toString()}",style: const TextStyle(

                  fontSize: 12,

                  color: Colors.black,

                  fontWeight: FontWeight.w700,

                  fontStyle: FontStyle.normal,

                )),

                Text("Cvv                   : ${data[index].cvv.toString()}",style: const TextStyle(

                  fontSize: 12,

                  color: Colors.black,

                  fontWeight: FontWeight.w700,

                  fontStyle: FontStyle.normal,

                ))

              ],

            ),
            Container(
              width: 10,
            ),
            IconButton(
                onPressed: () {
                  final Map<dynamic,
                      NotesModal> deliveriesMap = box.toMap();
                  dynamic desiredKey;
                  deliveriesMap.forEach((key,
                      value) {
                    if (value.cardnumber == box.values
                        .take(index + 1)
                        .first
                        .cardnumber)
                      desiredKey = key;
                  });

                  box.delete(desiredKey);
                },
                icon: const Icon(Icons.delete,
                  color: Colors.black,)),
          ],

        ),

      );

    }

),
          )
  ],
);
     }
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
