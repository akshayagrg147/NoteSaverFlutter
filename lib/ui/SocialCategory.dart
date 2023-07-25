import 'package:cardsaver/Utils/whatsapp_share.dart';
import 'package:cardsaver/models/boxes.dart';
import 'package:cardsaver/models/notes_modal.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

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
  String? nullicon;

  // ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var listenable = Boxes.getSocialPasswords().listenable();
    // if (widget.categoryType.contains('facebook')) {
    //   listenable = Boxes.getFacebookPasswords().listenable();
    // }
    String title = "Facebook";

    var listenable = Boxes.getFacebookPasswords().listenable();
    if (widget.categoryType.contains('Instagram')) {
      listenable = Boxes.getInstagramPasswords().listenable();
      title = "Instagram";
    } else if (widget.categoryType.contains('google')) {
      listenable = Boxes.getgooglePasswords().listenable();
      title = "Google";
    }else if (widget.categoryType.contains('internetBanking')) {
      listenable = Boxes.getBankingPasswords().listenable();
      title = "Internet Banking";
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            }else if (widget.categoryType.contains('internetBanking')) {
              image = 'assets/gif/bank.gif';
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
                                    data[box.length - 1].username.toString());

                                return Card(
                                  color: Colors.white,
                                  elevation: 5,
                                  margin: const EdgeInsets.all(5),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Column(
                                      children: [
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
                                                          data[index].username.toString(),
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
                                                      text: data[index].password.toString(),
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
                                                    // usernameController.text = box.values.take(index + 1).last.username;
                                                    // passwordController.text = box.values.take(index + 1).last.password;
                                                    usernameController.text = data[index].username.toString();
                                                    passwordController.text = data[index].password.toString();
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
                                                  onPressed: () async {
                                                    box.deleteAt(index);
                                                    if (box.length == 0) {
                                                      setEmail(
                                                          widget.categoryType,
                                                          null);
                                                    }
                                                  },
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Colors.black26,
                                                  )),
                                              IconButton(

                                                  onPressed: () {
                                                    ShareToWhatsapp whatsapp = ShareToWhatsapp();
                                                    whatsapp.send("Account: $title\nUsername: ${data[index].username}\nPassword: ${data[index].password}");
                                                  },
                                                  icon: const Icon(
                                                    LineAwesomeIcons.what_s_app,
                                                    color: Colors.black26,
                                                  )),

                                            ],
                                          ),
                                          onLongPress: () async {
                                            await Clipboard.setData(ClipboardData(
                                                text:
                                                    data[index].password.toString()));
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
                                                    data[index].username.toString()));
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
    emailData,
  ) async {
    var sharedpref = await SharedPreferences.getInstance();

    if (widget.categoryType.contains('google')) {
      if (emailData != null) {
        sharedpref.setString("googleEmail", emailData);
        setState(() {});
      } else {
        await sharedpref.remove("googleEmail");
      }
    } else if (widget.categoryType.contains('facebook')) {
      if (emailData != null) {
        sharedpref.setString("facebookEmail", emailData);
        setState(() {});
      } else {
        await sharedpref.remove("facebookEmail");
      }
    } else if (widget.categoryType.contains('Instagram')) {
      if (emailData != null) {
        sharedpref.setString("instagramEmail", emailData);
        setState(() {});
      } else {
        await sharedpref.remove("instagramEmail");
      }
    } else if (widget.categoryType.contains('internetBanking')) {
      if (emailData != null) {
        sharedpref.setString("internetBankingUsername", emailData);
        setState(() {});
      } else {
        await sharedpref.remove("internetBankingUsername");
      }
    }
    setState(() {});
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
        title: titleController.text,
        icon: nullicon);
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
    }else if (categoryType.contains('internetBanking')) {
      box = Boxes.getBankingPasswords();
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

    showModalBottomSheet<void>(
        // context and builder are
        // required properties in this widget
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFff6f1),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              height: 260,
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
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
                                      BorderRadius.all(Radius.circular(15))),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
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
                        height: 14,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
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
                                    BorderRadius.all(Radius.circular(15))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter password";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      GestureDetector(
                        onTap: () {
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
                              horizontal: 20, vertical: 0),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
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
}
