
import 'package:cardsaver/notesave/boxes.dart';
import 'package:cardsaver/notesave/notes_modal.dart';
import 'package:flutter/material.dart';
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
  final titleController = TextEditingController();
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title:  Text(widget.categoryType),

        ),
      body: ValueListenableBuilder(

          valueListenable: Boxes.getSocialPasswords().listenable(),
          builder: (context,box,_){
            var data=box.values.toList().cast<SocialModal>();
            var image= 'assets/gif/others.gif';
            if(widget.categoryType.contains('facebook')){
              image= 'assets/gif/faceboook.gif';
            }
            else  if(widget.categoryType.contains('Instagram')){
              image= 'assets/gif/instagram.gif';
            }
            return Container(
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(

                children: [
                  Image.asset(
                    image,
                    width: double.infinity,
                    height: 250,
                  ),
                  const SizedBox(
              height: 20,
              ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: box.length,
                        itemBuilder: (context,index) {
                          var valueTitle = data[index].title;
                          var visibilityTilte = true;
                          if (valueTitle.isEmpty||valueTitle.contains("null")||valueTitle.contains("empty")) {
                            visibilityTilte = false;
                          }
                          return Card(
                            color: Colors.white,
                            elevation: 5,
                            margin: const EdgeInsets.all(5),
                            child: SizedBox(
                              width: double.infinity,

                              child: Column(
                                children: [
                                  Visibility(
                                    visible: visibilityTilte,
                                    child: Text(
                                      "Title : ${data[index].title.toString()}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black26,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.amber,
                                      child: Text(index.toString()),
                                    ),
                                    title: Text("UName:${data[index].username
                                        .toString()}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black26,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),

                                    subtitle: Text(
                                      "UPassword :${data[index].password
                                          .toString()}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black26,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.italic,
                                      ),),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(onPressed: () {
                                          
                                          usernameController.text = box.values
                                              .take(index + 1)
                                              .first
                                              .username;
                                          passwordController.text = box.values
                                              .take(index + 1)
                                              .first
                                              .password;
                                          callBottomSheet(
                                              context, usernameController,
                                              passwordController,
                                              titleController, index, "null");
                                        },
                                            icon: const Icon(Icons.edit,
                                              color: Colors.black26,)),
                                        IconButton(
                                            onPressed: () {
                                              final Map<dynamic,
                                                  SocialModal> deliveriesMap = box
                                                  .toMap();
                                              dynamic desiredKey;
                                              deliveriesMap.forEach((key,
                                                  value) {
                                                if (value.username == box.values
                                                    .take(index + 1)
                                                    .first
                                                    .username) {
                                                  desiredKey = key;
                                                }
                                              });

                                              box.delete(desiredKey);
                                            },
                                            icon: const Icon(Icons.delete,
                                              color: Colors.black26,)),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                  ),
                  )],
              ),
            ); }
      ),
        floatingActionButton: FloatingActionButton(
          // isExtended: true,
          backgroundColor: Colors.green,
          onPressed: () {
            usernameController.text="";
            passwordController.text="";
           callBottomSheet(context,usernameController,passwordController,titleController,-1,widget.categoryType);
          },
          // isExtended: true,
          child: const Icon(Icons.add),
        ),

      );

  }

  void doNothing(BuildContext context) {
  }
}


void _onValidate(TextEditingController usernameController,TextEditingController passwordController,TextEditingController titleController, int position) {

    final data = SocialModal(username: usernameController.text, password: passwordController.text, title: titleController.text);
    final box = Boxes.getSocialPasswords();
    if(position!=-1) {
      box.delete(position+1);
    }
    box.add(data);
    print('valid!');

}
  bool passwordValidationResult = false;
  bool usernameValidationResult = false;
  final _formKey = GlobalKey<FormState>();
void callBottomSheet(BuildContext context, TextEditingController usernameController, TextEditingController passwordController,TextEditingController titleController, int position, String categoryType) {
  bool _titleVisibility = true;
  if(categoryType.contains('facebook')|categoryType.contains('Instagram')|categoryType.contains('null')){
    _titleVisibility=false;
    titleController.text="empty";
  }
  showModalBottomSheet<void>(
    // context and builder are
    // required properties in this widget
      context: context,
      builder: (BuildContext context) {
        // we set up a container inside which
        // we create center column and display text

        // Returning SizedBox instead of a Container
        return Container(
          color: Colors.transparent,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.lightBlue,
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
                      child: TextFormField(
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
                          validator: (value){
                            if(value!.isEmpty){
                              usernameValidationResult = false;
                              return "Please enter Username/Email";
                            }else{
                              //call function to check password
                              usernameValidationResult = true;
                              // _onValidate(usernameController,passwordController);
                              return null;
                            }
                          }
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
                             passwordValidationResult = false;
                             return "Please enter password";
                           }else{
                             //call function to check password
                             passwordValidationResult = true;
                             // _onValidate(usernameController,passwordController);
                             return null;
                           }
                         },
                    ),
                     ),
                    const SizedBox(
                      height: 5,
                    ),
                    Visibility(
                      visible: _titleVisibility,
                      child: TextField(
                        controller: titleController,

                        decoration: const InputDecoration(
                            hintText: "Enter any title",
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            )
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: (){
                        _formKey.currentState!.validate();
                        if(usernameValidationResult == true && passwordValidationResult == true){
                          _onValidate(usernameController,passwordController,titleController,position);
                        }
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
                          'Save',
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
          ),
        );
      });
}
