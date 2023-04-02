import 'package:cardsaver/notesave/boxes.dart';
import 'package:cardsaver/notesave/notes_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SocialScreen extends StatefulWidget {
  final String categoryType;
  const SocialScreen(this.categoryType, {Key? key}) : super(key: key);

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  Text(widget.categoryType),

        ),
      body: ValueListenableBuilder<Box<SocialModal>>(
          valueListenable: Boxes.getSocialPasswords().listenable(),
          builder: (context,box,_){
            var data=box.values.toList().cast<SocialModal>();
            return ListView.builder(
                itemCount: box.length,
                itemBuilder: (context,index){
                  return Card(
                    child: Column(
                      children: [
                        Text("UserName:${data[index].username.toString()}"),
                        Text("Password :${data[index].password.toString()}"),

                      ],
                    ),
                  );
                }
            ); }
      ),
        floatingActionButton: FloatingActionButton(
          // isExtended: true,
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
          onPressed: () {
           callBottomSheet(context,usernameController,passwordController);
          },
        ),

      );

  }
}
void _onValidate(TextEditingController usernameController,TextEditingController passwordController) {

    final data = SocialModal(username: usernameController.text, password: passwordController.text, category: '');
    final box = Boxes.getSocialPasswords();
    box.add(data);
    print('valid!');

}
void callBottomSheet(BuildContext context, TextEditingController usernameController, TextEditingController passwordController) {
  showModalBottomSheet<void>(
    // context and builder are
    // required properties in this widget
      context: context,
      builder: (BuildContext context) {
        // we set up a container inside which
        // we create center column and display text

        // Returning SizedBox instead of a Container
        return SizedBox(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  <Widget>[
                TextField(
                controller: usernameController,
                  decoration: const InputDecoration(
                    hintText: "Enter Email",
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                 TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                      hintText: "Enter Password",
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                GestureDetector(
                  onTap: (){
                    _onValidate(usernameController,passwordController);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const Text(
                      'Save Information',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'halter',
                        fontSize: 14,
                        package: 'flutter_credit_card',
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        );
      });
}
