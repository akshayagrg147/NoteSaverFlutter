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
  // final cardnumber = TextEditingController();
  var colorNames = [Colors.pink,Colors.lightBlue,Colors.orange,Color(0xFF090943),Color(0xFF000000),Colors.yellow,Colors.red,Colors.grey,Colors.black,Colors.amber];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf4f4f4),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 28,bottom: 5),
          child: Text("Card Manager",style: TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500)),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ValueListenableBuilder<Box<NotesModal>>(
          valueListenable: Boxes.getdata().listenable(),
          builder: (context, box, _) {
            var data = box.values.toList().cast<NotesModal>();
            return Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 5),
              child: ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    return _buildCreditCard(
                        color: colorNames[index],
                        cardExpiration: data[index].expiry.toString(),
                        cardHolder: data[index].cardholder.toString(),
                        cardNumber: data[index].cardnumber.toString(),
                        bankName: data[index].bankName.toString(),
                        cvv: data[index].cvv.toString(),box:box, index:index);

                    //     Card(
                    //   child: Row(
                    //     children: [
                    //       Icon(Icons.add_card),
                    //       Container(
                    //         width: 10,
                    //       ),
                    //       Column(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text("Card Number  : ${data[index].cardnumber.toString()}"),
                    //           Text("Holder name   : ${data[index].cardholder.toString()}"),
                    //           Text("Expiry               : ${data[index].expiry.toString()}"),
                    //           Text("Cvv                   : ${data[index].cvv.toString()}")
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // );
                  }),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreditCardPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Card _buildCreditCard({
    required Color color,
    required String cardNumber,
    required String cardHolder,
    required String cardExpiration,
    required String bankName,
    required String cvv,
    required Box<NotesModal> box,
    required int index
  }) {
    return Card(
      elevation: 4.0,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        height: 169,
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildLogosBlock(box,index),
            Center(
              child: Text(
                '$bankName',
                style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                '$cardNumber',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontFamily: 'CourrierPrime'),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'cvv ',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$cvv',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'CourrierPrime'),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildDetailsBlock(
                  label: 'CARDHOLDER',
                  value: cardHolder,
                ),
                _buildDetailsBlock(label: 'VALID THRU', value: cardExpiration),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row _buildLogosBlock(Box<NotesModal> box,int index){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.asset(
          "assets/images/contact_less.png",
          height: 20,
          width: 18,
        ),
        IconButton(
            onPressed: () {
              final Map<dynamic, NotesModal> deliveriesMap = box.toMap();
              dynamic desiredKey;
              deliveriesMap.forEach((key, value){
                if (value.cardnumber == box.values.take(index+1).first.cardnumber) {
                  desiredKey = key;
                }
              });

              box.delete(desiredKey);
            },
            icon: const Icon(Icons.delete_forever,size: 28,)),
        // Container(
        //   height: 50,
        //     width: 30,
        //     child: Icon(Icons.delete_forever,size: 28,))
      ],
    );
  }


  Column _buildDetailsBlock({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
              color: Colors.white70, fontSize: 9, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: const TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

}
