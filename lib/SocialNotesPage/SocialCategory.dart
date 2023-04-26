//line 21, 25-28, 52-56,262-265,294-299,391-414,
//285 , 344,378,418,
import 'package:cardsaver/notesave/boxes.dart';
import 'package:cardsaver/notesave/notes_modal.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  // ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    // var listenable = Boxes.getSocialPasswords().listenable();
    // if (widget.categoryType.contains('facebook')) {
    //   listenable = Boxes.getFacebookPasswords().listenable();
    // }

    var listenable = Boxes.getFacebookPasswords().listenable();
    if (widget.categoryType.contains('Instagram')) {
      listenable = Boxes.getInstagramPasswords().listenable();
    } else if (widget.categoryType.contains('google')) {
      listenable = Boxes.getgooglePasswords().listenable();
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          widget.categoryType,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color(0xFFf4f4f4),
      ),
      body: ValueListenableBuilder(
          valueListenable: listenable,
          builder: (context, box, _) {
            var data = box.values.toList().cast<SocialModal>();
            // var image = 'assets/gif/others.gif';
            // if (widget.categoryType.contains('facebook')) {
            //   image = 'assets/gif/facebook.gif';
            // }

            var image = 'assets/gif/facebook.gif';
            if (widget.categoryType.contains('Instagram')) {
              image = 'assets/gif/insta.gif';
            } else if (widget.categoryType.contains('google')) {
              image = 'assets/gif/google.gif';
            }

            return box.length == 0
                ? Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFf4f4f4),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 29,
                        ),
                        Image.asset(
                          image,
                          width: double.infinity,
                          height: 200,
                        ),
                        const SizedBox(
                          height: 29,
                        ),
                        Container(
                          height: ((MediaQuery.of(context).size.height) / 2) -
                              60 -
                              280,
                        ),
                        SizedBox(
                          height: 105,
                          width: double.infinity,
                          child: IconButton(
                            onPressed: () {
                              usernameController.text = "";
                              passwordController.text = "";
                              callBottomSheets(
                                  context,
                                  usernameController,
                                  passwordController,
                                  titleController,
                                  -1,
                                  widget.categoryType);
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
                          child: Text("Save New Passwords",
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500)),
                        )
                      ],
                    ),
                  )
                : Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFf4f4f4),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 29,
                        ),
                        Image.asset(
                          image,
                          width: double.infinity,
                          height: 200,
                        ),
                        const SizedBox(
                          height: 29,
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: box.length,
                              itemBuilder: (context, index) {
                                setEmail(widget.categoryType,
                                    "${data[box.length - 1].username.toString()}");
                                String maskingPassword =
                                    '"${data[index].password.toString()}"';
                                String maskedPassword = "";
                                if (maskingPassword.length > 3) {
                                  maskedPassword = maskingPassword[0] +
                                      maskingPassword[1] +
                                      "*" * (maskingPassword.length - 4) +
                                      maskingPassword[
                                          (maskingPassword.length - 2)] +
                                      maskingPassword[
                                          (maskingPassword.length - 1)];
                                } else {
                                  maskedPassword = maskingPassword;
                                }

                                // var valueTitle = data[index].title;
                                // var visibilityTilte = true;
                                // if (valueTitle.isEmpty||valueTitle.contains("null")||valueTitle.contains("empty")) {
                                //   visibilityTilte = false;}

                                return Card(
                                  color: Colors.white,
                                  elevation: 5,
                                  margin: const EdgeInsets.all(5),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        // Visibility(
                                        //   visible: visibilityTilte,
                                        //   child: Text(
                                        //     "Title : ${data[index].title.toString()}",
                                        //     style: const TextStyle(
                                        //       fontSize: 12,
                                        //       color: Colors.black26,
                                        //       fontWeight: FontWeight.w700,
                                        //       fontStyle: FontStyle.normal,
                                        //     ),
                                        //   ),
                                        // ),
                                        ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor: Colors.amberAccent,
                                            child: Text((index + 1).toString()),
                                          ),
                                          title: RichText(
                                            text: TextSpan(
                                                text: "Username:\n",
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          "${data[index].username.toString()}",
                                                      style: const TextStyle(
                                                          color:
                                                              Colors.black45))
                                                ]),
                                          ),
                                          subtitle: RichText(
                                            text: TextSpan(
                                                text: "Password:\n",
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: maskedPassword,
                                                      style: const TextStyle(
                                                          color:
                                                              Colors.black45))
                                                ]),
                                          ),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    usernameController.text =
                                                        box.values
                                                            .take(index + 1)
                                                            .last
                                                            .username;
                                                    passwordController.text =
                                                        box.values
                                                            .take(index + 1)
                                                            .last
                                                            .password;
                                                    callBottomSheets(
                                                        context,
                                                        usernameController,
                                                        passwordController,
                                                        titleController,
                                                        index,
                                                        widget.categoryType);
                                                  },
                                                  icon: const Icon(
                                                    Icons.edit,
                                                    color: Colors.black26,
                                                  )),
                                              IconButton(
                                                  onPressed: () {

                                                    // final Map<dynamic,
                                                    //     SocialModal> deliveriesMap = box
                                                    //     .toMap();
                                                    // dynamic desiredKey;
                                                    // deliveriesMap.forEach((key,
                                                    //     value) {
                                                    //   if (value.username == box.values
                                                    //       .take(index + 1)
                                                    //       .last
                                                    //       .username) {
                                                    //     desiredKey = key;
                                                    //   }
                                                    // });
                                                    // box.delete(desiredKey);

                                                    box.deleteAt(index);
                                                  },
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Colors.black26,
                                                  )),
                                            ],
                                          ),
                                          onLongPress: () async {
                                            await Clipboard.setData(ClipboardData(
                                                text:
                                                    "${data[index].password.toString()}"));
                                            Fluttertoast.showToast(
                                                msg: "Password Copied",
                                                toastLength: Toast.LENGTH_SHORT,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.black54,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          },
                                          onTap: () async {
                                            await Clipboard.setData(ClipboardData(
                                                text:
                                                    "${data[index].username.toString()}"));
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Username Copied\nLongPress to Copy Password",
                                                toastLength: Toast.LENGTH_SHORT,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.black54,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  );
          }),
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        backgroundColor: Colors.green,
        onPressed: () {
          usernameController.text = "";
          passwordController.text = "";
          callBottomSheets(context, usernameController, passwordController,
              titleController, -1, widget.categoryType);
        },
        // isExtended: true,
        child: const Icon(Icons.add),
      ),
    );
  }

  void setEmail(
    String categoryType,
    String emailData,
  ) async {
    var sharedpref = await SharedPreferences.getInstance();

    if (widget.categoryType.contains('google')) {
      sharedpref.setString("googleEmail", emailData);
      setState(() {});
    } else if (widget.categoryType.contains('facebook')) {
      sharedpref.setString("facebookEmail", emailData);
      setState(() {});
    } else if (widget.categoryType.contains('Instagram')) {
      sharedpref.setString("instagramEmail", emailData);
      setState(() {});
    }
  }

  void _onValidate(
      BuildContext context,
      TextEditingController usernameController,
      TextEditingController passwordController,
      TextEditingController titleController,
      int position,
      String categoryType) {
    final data = SocialModal(
        username: usernameController.text,
        password: passwordController.text,
        title: titleController.text);
    final navigator = Navigator.of(context);
    // var box = Boxes.getSocialPasswords();
    // if (categoryType.contains('facebook')) {
    //   box = Boxes.getFacebookPasswords();
    // }
    var box = Boxes.getFacebookPasswords();

    if (categoryType.contains('Instagram')) {
      box = Boxes.getInstagramPasswords();
    } else if (categoryType.contains('google')) {
      box = Boxes.getgooglePasswords();
    }

    if (position != -1) {
      box.putAt(position, data);
    } else if (position == -1) {
      box.add(data);
    }
    navigator.pop();
    // print('valid!');
  }

  // bool passwordValidationResult = false;
  // bool usernameValidationResult = false;
  final _formKey = GlobalKey<FormState>();

  void callBottomSheets(
      BuildContext context,
      TextEditingController usernameController,
      TextEditingController passwordController,
      TextEditingController titleController,
      int position,
      String categoryType) {
    // bool _titleVisibility = true;
    // if(categoryType.contains('facebook')|categoryType.contains('google')|categoryType.contains('Instagram')|categoryType.contains('null')){
    //   _titleVisibility=false;
    //   titleController.text="empty";
    // }

    showModalBottomSheet<void>(
        // context and builder are
        // required properties in this widget
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          // we set up a container inside which
          // we create center column and display text
          // Returning SizedBox instead of a Container
          return Container(
            decoration: const BoxDecoration(
              color: Color(0xFFFff6f1),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28), topRight: Radius.circular(28)),
            ),
            height: 240,
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 25.0),
                      child: TextFormField(
                          controller: usernameController,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            labelText: "Email/Username",
                            labelStyle:
                                TextStyle(fontSize: 16, color: Colors.black),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              // usernameValidationResult = false;
                              return "Please enter Username/Email";
                            } else {
                              // usernameValidationResult = true;
                              // _onValidate(usernameController,passwordController);
                              return null;
                            }
                          }),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 25.0),
                      child: TextFormField(
                        controller: passwordController,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          labelText: "Password",
                          labelStyle:
                              TextStyle(fontSize: 16, color: Colors.black),
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            // passwordValidationResult = false;
                            return "Please enter password";
                          } else {
                            // passwordValidationResult = true;
                            // _onValidate(usernameController,passwordController);
                            return null;
                          }
                        },
                      ),
                    ),
                    // const SizedBox(
                    //   height: 8,
                    // ),
                    // Visibility(
                    //   visible: _titleVisibility,
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(left:20.0, right:25.0),
                    //     child: TextField(
                    //       controller: titleController,
                    //
                    //       decoration: const InputDecoration(
                    //           hintText: "Enter any title",
                    //           labelText: "Title",
                    //           labelStyle: TextStyle(fontSize: 16),
                    //           hintStyle: TextStyle(fontSize: 16),
                    //           filled: true,
                    //           border: UnderlineInputBorder(
                    //             borderSide: BorderSide.none,
                    //             borderRadius: BorderRadius.all(Radius.circular(20)),
                    //           )
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        // if (usernameValidationResult == true &&
                        //     passwordValidationResult == true) {}
                        if (_formKey.currentState!.validate()) {
                          _onValidate(
                              context,
                              usernameController,
                              passwordController,
                              titleController,
                              position,
                              categoryType);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 0),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'halter',
                            fontSize: 18,
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
}
