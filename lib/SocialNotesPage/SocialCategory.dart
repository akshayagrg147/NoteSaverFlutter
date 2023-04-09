import 'package:cardsaver/notesave/boxes.dart';
import 'package:cardsaver/notesave/notes_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
      body: ValueListenableBuilder(

          valueListenable: Boxes.getSocialPasswords().listenable(),
          builder: (context,box,_){
            var data=box.values.toList().cast<SocialModal>();
            return Column(
              children: [
                Image.asset(
                  'assets/gif/facebook.gif',
                  width: double.infinity,
                  height: 250,
                ),
                const SizedBox(
            height: 20,
            ),
                Expanded(
                  child: ListView.builder(
                      itemCount: box.length,
                      itemBuilder: (context,index){
                        return Slidable(
                          key: const ValueKey(0),
                          // The start action pane is the one at the left or the top side.
                          startActionPane: ActionPane(
                            // A motion is a widget used to control how the pane animates.
                            motion: const ScrollMotion(),

                            // A pane can dismiss the Slidable.
                            dismissible: DismissiblePane(onDismissed: () {}),

                            // All actions are defined in the children parameter.
                            children:  [
                              // A SlidableAction can have an icon and/or a label.
                              SlidableAction(

                                backgroundColor: Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete', onPressed: (BuildContext context) {  },
                              ),
                              SlidableAction(
                                onPressed: doNothing,
                                backgroundColor: Color(0xFF21B7CA),
                                foregroundColor: Colors.white,
                                icon: Icons.share,
                                label: 'Share',
                              ),
                            ],
                          ),

                          // The end action pane is the one at the right or the bottom side.
                          endActionPane:  ActionPane(
                            motion: ScrollMotion(),
                            children: [
                              SlidableAction(
                                // An action can be bigger than the others.
                                flex: 2,
                                onPressed: (BuildContext context) {  },
                                backgroundColor: Color(0xFF7BC043),
                                foregroundColor: Colors.white,
                                icon: Icons.archive,
                                label: 'Archive',
                              ),
                              SlidableAction(
                                onPressed: doNothing,
                                backgroundColor: Color(0xFF0392CF),
                                foregroundColor: Colors.white,
                                icon: Icons.save,
                                label: 'Save',
                              ),
                            ],
                          ),
                          child: Card(
                            child: Column(
                              children: [
                                Text("UserName:${data[index].username.toString()}"),
                                Text("Password :${data[index].password.toString()}"),

                              ],
                            ),
                          ),

                        );
                      }
                  ),
                ),
              ],
            ); }
      ),
        floatingActionButton: FloatingActionButton(
          // isExtended: true,
          backgroundColor: Colors.green,
          onPressed: () {
           callBottomSheet(context,usernameController,passwordController);
          },
          // isExtended: true,
          child: const Icon(Icons.add),
        ),

      );

  }

  void doNothing(BuildContext context) {
  }
}


void _onValidate(TextEditingController usernameController,TextEditingController passwordController) {

    final data = SocialModal(username: usernameController.text, password: passwordController.text, category: '');
    final box = Boxes.getSocialPasswords();
    box.add(data);
    print('valid!');

}

// regular expression to check if string
// RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W) ");
//
// //A function that validate user entered password
// bool validatePassword(String pass){
//   String _password = pass.trim();
//
//   if(pass_valid.hasMatch(_password)){
//     return true;
//   }else{
//     return false;
//   }
// }


final _formKey = GlobalKey<FormState>();
void callBottomSheet(BuildContext context, TextEditingController usernameController, TextEditingController passwordController) {


  showModalBottomSheet<void>(
    // context and builder are
    // required properties in this widget
      context: context,
      builder: (BuildContext context) {
        // we set up a container inside which
        // we create center column and display text

        // Returning SizedBox instead of a Container
        return Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(topLeft:Radius.circular(35), topRight:Radius.circular(35)),
          ),
          height: 240,
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left:20.0,right:25.0),
                    child: TextField(
                    controller: usernameController,
                      decoration: const InputDecoration(
                        labelText: "Email/Username",
                        labelStyle: TextStyle(fontSize: 16),
                        // hintText: "Enter Email",
                        filled: true,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        )
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                   Padding(
                     padding: const EdgeInsets.only(left:20.0, right:25.0),
                     child: TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        labelText: "Password",
                          labelStyle: TextStyle(fontSize: 16),
                          // hintText: "Enter Password",
                          filled: true,
                          border: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          )
                      ),
                       validator: (value){
                         if(value!.isEmpty){
                           return "Please enter password";
                         }else{
                           //call function to check password
                           // bool result = validatePassword(value);
                           if(value.length >4){
                             // create account event
                             _onValidate(usernameController,passwordController);
                             return null;
                           }else{
                             return " Password must contain 4 character";
                           }
                         }
                       },
                  ),
                   ),
                  const SizedBox(
                    height: 5,
                  ),

                  GestureDetector(
                    onTap: (){
                      _formKey.currentState!.validate();
                      // _onValidate(usernameController,passwordController);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(15),
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
          ),
        );
      });
}
