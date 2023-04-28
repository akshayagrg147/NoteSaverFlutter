import 'package:cardsaver/notesave/boxes.dart';
import 'package:cardsaver/notesave/notes_modal.dart';
import 'package:cardsaver/ui/creditCardPage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf4f4f4),
      // backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Padding(
          padding: EdgeInsets.only(bottom: 5, top: 10),
          child: Text("Card Manager",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
              )),
        ),
        backgroundColor: const Color(0xFFf4f4f4),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreditCardPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder<Box<NotesModal>>(
          valueListenable: Boxes.getdata().listenable(),
          builder: (context, box, _) {
            var data = box.values.toList().cast<NotesModal>();
            int selectedColor = Colors.black.value;
            return box.length == 0
                ? Column(
                    children: [
                      Container(
                        height: ((MediaQuery.of(context).size.height) / 2) -
                            50 - 80,
                      ),
                      SizedBox(
                        height: 105,
                        width: double.infinity,
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CreditCardPage()),
                            );
                          },
                          icon: const Icon(
                            Icons.add_circle_outline_rounded,
                            color: Colors.black26,
                            size: 100,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Text("Add More Cards",
                            style: TextStyle(
                                color: Colors.black38,
                                fontSize: 19,
                                fontWeight: FontWeight.w500)),
                      )
                    ],
                  )
                : Column(
                  children: [
                    Container(
                      height: 15,
                      // color: Colors.black,
                    ),
                    Expanded(
                      child: Padding(
                          padding:
                              const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                          child: ListView.builder(
                              itemCount: box.length,
                              itemBuilder: (context, index) {
                                if (data[index].color != null) {
                                  selectedColor = (data[index].color)!.toInt();
                                }
                                return _buildCreditCard(
                                  color: Color(selectedColor),
                                  cardExpiration: data[index].expiry.toString(),
                                  cardHolder: data[index].cardholder.toString(),
                                  cardNumber: data[index].cardnumber.toString(),
                                  bankName: data[index].bankname.toString(),
                                  cvv: data[index].cvv.toString(),
                                  index: index,
                                  cardType: data[index].cardtype.toString() == "null" ? "Card" : data[index].cardtype.toString() ,

                                );
                              }),
                        ),
                    ),
                  ],
                );
          }),
    );
  }
}

Padding _buildCreditCard({
  required Color color,
  required String cardNumber,
  required String cardHolder,
  required String cardExpiration,
  required String bankName,
  required String cvv,
  required String cardType,
  required int index,

}) {
  return Padding(
    padding: const EdgeInsets.only(bottom:5),
    child: Card(
      elevation: 4.0,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        height: 169,
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 16.0,top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildLogosBlock(index: index,cardtype: cardType),
            Center(
              child: InkWell(
                child: Text(
                  bankName,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
                onLongPress: () async{
                  await Clipboard.setData(ClipboardData(text: cardNumber));
                  Fluttertoast.showToast(
                      msg: "Card number Copied",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black54,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                },
              ),
            ),
            Center(
              child: InkWell(
                child: Text(
                  cardNumber,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontFamily: 'CourrierPrime'),
                ),
                onLongPress: () async{
                  await Clipboard.setData(ClipboardData(text: cardNumber));
                  Fluttertoast.showToast(
                      msg: "Card number Copied",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black54,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                },
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
                    cvv,
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
    ),
  );
}

ValueListenableBuilder _buildLogosBlock({
  required int index, required String cardtype,
}) {
  return ValueListenableBuilder<Box<NotesModal>>(
      valueListenable: Boxes.getdata().listenable(),
      builder: (context, box, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: 20,
              child: Text(cardtype, style: const TextStyle(color: Colors.white),)
            ),
            IconButton(
                onPressed: () {
                  box.deleteAt(index);
                },
                icon: const Icon(
                  Icons.delete_forever,
                  size: 28,
                )),
          ],
        );
      });
}


Column _buildDetailsBlock({required String label, required String value}) {
  String copyMsg;
  if(label == "CARDHOLDER"){
    copyMsg = "Holder Name Copied";
  }
  else{
    copyMsg = "Expiry Date Copied";
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[

      InkWell(
        child: Text(
          label,
          style: const TextStyle(
              color: Colors.white70, fontSize: 9, fontWeight: FontWeight.bold),
        ),
        onLongPress: () async{
          await Clipboard.setData(ClipboardData(text: value));
          Fluttertoast.showToast(
              msg: copyMsg,
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 16.0
          );
        },
      ),
      InkWell(
        child: Text(
          value,
          style: const TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        onLongPress: () async{
          await Clipboard.setData(ClipboardData(text: value));
          Fluttertoast.showToast(
              msg: copyMsg,
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 16.0
          );
        },
      )
    ],
  );
}