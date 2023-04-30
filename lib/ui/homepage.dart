//18 to 31
//836 - 930
import 'package:cardsaver/SocialNotesPage/SocialCategory.dart';
import 'package:cardsaver/Utils/appdrawer.dart';
import 'package:cardsaver/Utils/fingerprint.dart';
import 'package:cardsaver/Utils/iconselector.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cardsaver/Utils/categoryhscroll.dart';
import 'package:cardsaver/notesave/boxes.dart';
import 'package:cardsaver/notesave/notes_modal.dart';
import 'package:cardsaver/notesfile/add_note_bottom_sheet.dart';
import 'package:cardsaver/ui/creditCardPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:upgrader/upgrader.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'NoteSaver',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primarySwatch: Colors.blueGrey,
      // ),
      home: MyHomePage(title: 'Card Saver'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double height = 0,
      width = 0;
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  final scaffoldKey = GlobalKey<ScaffoldState>();


  String search = '';
  TextEditingController searchController = TextEditingController();
  var facebookEmail = "No Password" ;
  var instagramEmail = "No Password";
  var googleEmail = "No Password";
  var selectedicon = "assets/images/avatar.png";
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final titleController = TextEditingController();


  @override
  void initState() {
    super.initState();
    FingerPrint fp = FingerPrint();
    fp.authenticate();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (isDialOpen.value) {
            isDialOpen.value = false;
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFf4f4f4),
          key: scaffoldKey,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: const Color(0xFFf4f4f4),
            iconTheme: IconThemeData(color: Colors.black),
            // leading: IconButton(
            //   icon: const Icon(Icons.sort),
            //   color: Colors.black,
            //   tooltip: 'Menu',
            //   onPressed: () {
            //     // if(scaffoldKey.currentState!.isDrawerOpen){
            //     //   scaffoldKey.currentState!.closeDrawer();
            //     //   //close drawer, if drawer is open
            //     // }else{
            //     // scaffoldKey.currentState!.openDrawer();
            //     // //open drawer, if drawer is closed
            //     // }
            //   },
            // ), //IconButton
            actions: const <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 10, top: 10),
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/avatar.png"),
                  backgroundColor: Colors.red,
                  radius: 22,
                ),
              ),
            ], //<Widget>[]
          ),
          drawer: AppDrawer(),
          floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.add_event,
            openCloseDial: isDialOpen,
            backgroundColor: Colors.redAccent,
            overlayColor: Colors.grey,
            overlayOpacity: 0.5,
            spacing: 15,
            spaceBetweenChildren: 15,
            // closeManually: true,
            children: [
              SpeedDialChild(
                  backgroundColor: Colors.black26,
                  child: Image.asset(
                    'assets/images/card.png',
                    height: 40,
                    width: 40,
                  ),
                  label: 'Card',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CreditCardPage()),
                    );
                  }),
              SpeedDialChild(
                  backgroundColor: Colors.black26,
                  child: Image.asset(
                    'assets/images/notes.png',
                    height: 38,
                    width: 38,
                  ),
                  label: 'Notes',
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: const Color(0xFFFff6f1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        context: context,
                        builder: (context) {
                          return const AddNoteBottomSheet(navigator: "tonotespage",);
                        });
                  }),
              SpeedDialChild(
                  backgroundColor: Colors.black26,
                  child: Image.asset(
                    'assets/images/others.png',
                    height: 40,
                    width: 40,
                  ),
                  label: 'Password',
                  onTap: () {
                    callBottomSheets(context,usernameController,passwordController,titleController,-1);
                  }),
            ],
          ),

          body: UpgradeAlert(
            child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFf4f4f4),
                ),
                child:
                ValueListenableBuilder<Box <SocialModal>>(
                    valueListenable: Boxes.getSocialPasswords().listenable(),
                    builder: (context, box, _) {
                      var data = box.values.toList().cast<SocialModal>();
                      getEmail();
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 15),
                              child: SizedBox(
                                height: 44,
                                child: TextFormField(
                                  controller: searchController,
                                  autofocus: false,
                                  style: const TextStyle(color: Colors.black),
                                  onChanged: (String? value) {
                                    setState(() {
                                      search = value.toString();
                                    });
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 15),
                                    hintText: 'Search "passwords"',
                                    hintStyle: const TextStyle(color: Colors.grey),
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.7),
                                      ),
                                      borderRadius:
                                      const BorderRadius.all(Radius.circular(15)),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.search,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 20,
                              ),
                              child: Text(
                                "Categories",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: HorizontalScroll(),
                            ),
                            Container(
                                child: searchController.text.isEmpty
                                    ? Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFff6f1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  margin: const EdgeInsets.only(
                                    left: 15,
                                    right: 15,
                                    top: 1,
                                  ),
                                  child: ListTile(
                                    contentPadding:
                                    const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                        vertical: 0.0),
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(width: 2),
                                      borderRadius:
                                      BorderRadius.circular(20),
                                    ),
                                    title: const Text(
                                      "Google Account",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),

                                    subtitle: Text(
                                      googleEmail,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12),
                                    ),
                                    leading: const CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/google.png"),
                                      radius: 20,
                                      backgroundColor: Colors.white,
                                    ),
                                    // trailing:
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const SocialScreen(
                                                "google")),
                                      );
                                    },
                                  ),
                                )
                                    : Container(
                                  height: 1,
                                )),
                            Container(
                                child: searchController.text.isEmpty
                                    ? Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFff6f1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  margin: const EdgeInsets.only(
                                    left: 15,
                                    right: 15,
                                    top: 8,
                                  ),
                                  child: ListTile(
                                    contentPadding:
                                    const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                        vertical: 0.0),
                                    shape: RoundedRectangleBorder(
                                      //<-- SEE HERE
                                      side: const BorderSide(width: 2),
                                      borderRadius:
                                      BorderRadius.circular(20),
                                    ),
                                    title: const Text(
                                      "Instagram",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      instagramEmail,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12),
                                    ),
                                    leading: const CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/instagram.png"),
                                      radius: 20,
                                    ),
                                    // trailing:
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const SocialScreen(
                                                'Instagram')),
                                      );
                                    },
                                  ),
                                )
                                    : Container(
                                  height: 1,
                                )),
                            Container(
                                child: searchController.text.isEmpty
                                    ? Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFff6f1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  margin: const EdgeInsets.only(
                                      left: 15,
                                      right: 15,
                                      top: 8,
                                      bottom: 5),
                                  child: ListTile(
                                    contentPadding:
                                    const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                        vertical: 0.0),
                                    shape: RoundedRectangleBorder(
                                      //<-- SEE HERE
                                      side: const BorderSide(width: 2),
                                      borderRadius:
                                      BorderRadius.circular(20),
                                    ),
                                    title: const Text(
                                      "Facebook",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      facebookEmail,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12),
                                    ),
                                    leading: const CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/facebook.png"),
                                      radius: 20,
                                    ),
                                    // trailing:
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const SocialScreen(
                                                "facebook")),
                                      );
                                    },
                                  ),
                                )
                                    : Container(
                                  height: 1,
                                )),

                            if (searchController.text.isEmpty && box.length != 0)
                              (const Padding(
                                padding: EdgeInsets.only(left: 20, top: 5),
                                child: Text(
                                  "Recently Added",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20),
                                ),
                              )),
                            const SizedBox(
                              height: 5,
                            ),
                            if (box.length == 0 &&
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height > 550)
                              (SizedBox(
                                height:
                                (MediaQuery
                                    .of(context)
                                    .size
                                    .height - 525) /
                                    5,
                              )),
                            if (box.length == 0)
                              (Column(
                                children: [
                                  SizedBox(
                                    height: 105,
                                    width: double.infinity,
                                    child: IconButton(
                                      onPressed: () {
                                        callBottomSheets(context,
                                          usernameController,passwordController,titleController,-1
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
                                    padding: EdgeInsets.only(top: 10, bottom: 25),
                                    child: Text("Save More Passwords",
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: 19,
                                            fontWeight: FontWeight.w500)),
                                  )
                                ],
                              )),


                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: box.length,
                                itemBuilder: (context, index) {
                                  late String position = data[index].title.toString();

                                  if (searchController.text.isEmpty) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        // color: Color(0xFFfce8d6),
                                        color: const Color(0xFFFff6f1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      margin: const EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        top: 10,
                                      ),
                                      child: ListTile(
                                        contentPadding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 10.0,
                                            vertical: 0.0),
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(width: 2),
                                          borderRadius:
                                          BorderRadius.circular(20),
                                        ),
                                        title: Text(
                                          data[index].title.toString(),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          data[index].username.toString(),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                        leading: Image.asset(
                                          data[index].icon.toString(),
                                          height: 40,
                                          width: 40,
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            InkWell(

                                                onTap: () async{
                                                await Clipboard.setData(ClipboardData(text: data[index].username.toString()));
                                                Fluttertoast.showToast(
                                                    msg: "Username Copied\nLong Press to copy Password",
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.black54,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                );},
                                                onLongPress: () async{
                                                  await Clipboard.setData(ClipboardData(text: data[index].password.toString()));
                                                  Fluttertoast.showToast(
                                                      msg: "Password Copied",
                                                      toastLength: Toast.LENGTH_SHORT,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor: Colors.black54,
                                                      textColor: Colors.white,
                                                      fontSize: 16.0
                                                  );
                                                },
                                                child: const Icon(Icons.content_copy,
                                                  color: Colors.black26,)),
                                            IconButton(
                                                onPressed: () {
                                                  box.deleteAt(index);
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.black26,
                                                )),
                                          ],
                                        ),
                                        onLongPress: () {
                                          usernameController.text = data[index].username.toString();
                                          passwordController.text = data[index].password.toString();
                                          titleController.text = data[index].title.toString();

                                          callBottomSheets(
                                              context,
                                              usernameController,
                                              passwordController,
                                              titleController,
                                              index,);
                                        },
                                      ),
                                    );
                                  } else if (position.toLowerCase().contains(
                                      searchController.text.toLowerCase())) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFff6f1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      margin: const EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        top: 10,
                                      ),
                                      child: ListTile(
                                        contentPadding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 10.0,
                                            vertical: 0.0),
                                        shape: RoundedRectangleBorder(
                                          //<-- SEE HERE
                                          side: const BorderSide(width: 2),
                                          borderRadius:
                                          BorderRadius.circular(20),
                                        ),
                                        title: Text(
                                          data[index].title.toString(),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          data[index].username.toString(),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                        leading: Image.asset(
                                          data[index].icon.toString(),
                                          height: 32,
                                          width: 32,
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            InkWell(

                                              onTap: () async{
                                                await Clipboard.setData(ClipboardData(text: data[index].username.toString()));
                                                Fluttertoast.showToast(
                                                    msg: "Username Copied\nLong Press to copy Password",
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.black54,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0
                                                );},
                                              onLongPress: () async{
                                              await Clipboard.setData(ClipboardData(text: data[index].password.toString()));
                                              Fluttertoast.showToast(
                                              msg: "Password Copied",
                                              toastLength: Toast.LENGTH_SHORT,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.black54,
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                              );
                                              },
                                                child: const Icon(Icons.content_copy,
                                                  color: Colors.black26,)),
                                            IconButton(
                                                onPressed: () {
                                                  box.deleteAt(index);
                                                },
                                                icon: const Icon(
                                                  Icons.delete_outlined,
                                                  color: Colors.black38,
                                                )),
                                          ],
                                        ),
                                        onTap: () {
                                          usernameController.text = data[index].username.toString();
                                          passwordController.text = data[index].password.toString();
                                          titleController.text = data[index].title.toString();

                                          callBottomSheets(
                                            context,
                                            usernameController,
                                            passwordController,
                                            titleController,
                                            index,);
                                        },
                                      ),
                                    );

                                  } else {
                                    return Container();
                                  }
                                }),

                            //  end here
                          ],
                        ),
                      );
                    })),
          ),
        ));
  }

  void getEmail() async {
    var sharedpref = await SharedPreferences.getInstance();
    var facebookEmailId = sharedpref.getString("facebookEmail");
    var instagramEmailId = sharedpref.getString("instagramEmail");
    var googleEmailId = sharedpref.getString("googleEmail");
    var sIcon = sharedpref.getString("selectedicon");
    setState(() {
      facebookEmail =
          facebookEmailId ?? "No Account Saved";
    });
    setState(() {
      instagramEmail =
      instagramEmailId ?? "No Account Saved";
    });
    setState(() {
      googleEmail = googleEmailId ?? "No Account Saved";
    });
    setState(() {
      selectedicon =
          sIcon ?? "assets/images/avatar.png";
    });
  }

  void callBottomSheets(
      BuildContext context,
      TextEditingController emailController,
      TextEditingController passController,
      TextEditingController titleController,
      int position,
      ) {
    // final titleController = TextEditingController();
    // final emailController = TextEditingController();
    // final passController = TextEditingController();
    showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                    color: Color(0xFFFff6f1),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15))),
                height: 418,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: TextFormField(
                            controller: titleController,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              labelText: "Title/Website Name",
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
                                return "Please enter Username/Email";
                              } else {
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
                            controller: emailController,
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
                                return "Please enter Username/Email";
                              } else {
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
                            controller: passController,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              labelText: "Password",
                              labelStyle:
                              TextStyle(fontSize: 16, color: Colors.black),
                              // hintText: "Enter Email",
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
                                return "Password";
                              } else {
                                return null;
                              }
                            }),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      const Padding(
                          padding: EdgeInsets.only(left: 16.5 ,right:16.5),
                          child: IconSelecting()
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      GestureDetector(
                        onTap: () {
                          onValidate(
                            context,
                            emailController,
                            passController,
                            titleController,
                            position,
                          );
                        },
                        child: Container(
                          height: 55,
                          margin:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                          decoration: BoxDecoration(
                            // color: Colors.red,
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: const Text(
                            'Save Password',
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

  void onValidate(BuildContext context, TextEditingController usernameController, TextEditingController passwordController, TextEditingController titleController,int position) {
    final data = SocialModal(
        username: usernameController.text,
        password: passwordController.text,
        title: titleController.text,
        icon: selectedicon);
    final navigator = Navigator.of(context);
    var box = Boxes.getSocialPasswords();
    if (position != -1) {
      box.putAt(position, data);
    } else if (position == -1) {
      box.add(data);
    }
    navigator.pop();
  }




}