import 'package:cardsaver/SocialNotesPage/SocialCategory.dart';
import 'package:cardsaver/Utils/SearchField.dart';
import 'package:cardsaver/Utils/categoryhScroll.dart';
import 'package:cardsaver/notesave/boxes.dart';
import 'package:cardsaver/notesave/notes_modal.dart';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
//Global declarations
class Language {
  String name;
  bool isChecked;
  Language(this.name, {this.isChecked = false});

}

final List<Language> languages = [Language('Twiiter') ,Language('Google'),  Language('instagram') , Language('Github'),Language('Slack'),Language('Linkedin')];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoteSaver',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Card Saver'),
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
  double height = 0, width = 0;
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

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
          appBar: AppBar(

            backgroundColor: Colors.purple[900],
            leading: IconButton(
              icon: Icon(Icons.menu),
              tooltip: 'Menu',
              onPressed: () {},
            ), //IconButton
            actions: const <Widget>[
              CircleAvatar(backgroundImage: AssetImage("assets/images/1.png"),),
            ], //<Widget>[]
          ),
          floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            openCloseDial: isDialOpen,
            backgroundColor: Colors.redAccent,
            overlayColor: Colors.grey,
            overlayOpacity: 0.5,
            spacing: 15,
            spaceBetweenChildren: 15,
            // closeManually: true,
            children: [
              SpeedDialChild(
                  child: Icon(Icons.local_atm),
                  label: 'Facebook',
                  backgroundColor: Colors.blue,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SocialScreen("facebook")),
                    );
                  }
              ),
              SpeedDialChild(
                  child: const Icon(Icons.lock),
                  label: 'Instagram',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SocialScreen(
                              'Instagram')),
                    );
                  }
              ),

              SpeedDialChild(
                  child: const Icon(Icons.person),
                  label: 'Others',
                  onTap: () {
                    callBottomSheet(context);
                  }
              ),
            ],
          ),
          body: Container(

            decoration: const BoxDecoration(
              color: Colors.deepPurple,
              // borderRadius: BorderRadius.circular(20),
            ),

            child: Column(
              children: [
                 const SearchField(),
                 const SizedBox(height: 20,),
                 const hScroll(),
                 const SizedBox(height: 20,),
                ValueListenableBuilder<Box<CategoryModal>>(
                    valueListenable: Boxes.getCategoryModal().listenable(),
                    builder: (context, box, _) {
                      var data = box.values.toList().cast<CategoryModal>();
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: box.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              margin: const EdgeInsets.only(left: 20,
                                  right: 20,
                                  top: 10,
                                  bottom: 10),
                              child: ListTile(

                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                shape: RoundedRectangleBorder( //<-- SEE HERE
                                  side: const BorderSide(width: 2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                title: Text(data[index].category,
                                  style: const TextStyle(color: Colors.black),),
                                leading: CircleAvatar(
                                    backgroundImage: AssetImage(
                                        "assets/images/$index.png")),
                                trailing: const Icon(
                                  Icons.copy_all, color: Colors.black,),
                                onTap: () {

                                },


                              ),
                            );

                          }
                      );
                    }
                )

              ],
            ),
          )


      ),
    );
  }

  }
  void callBottomSheet(BuildContext context) {
    final categoryController = TextEditingController();
    showModalBottomSheet<void>(
      // context and builder are
      // required properties in this widget
        context: context,
        builder: (BuildContext context) {
           return Container(
             decoration: BoxDecoration(
               color: Colors.deepPurple,
               borderRadius: BorderRadius.circular(20),
             ),
             child: Center(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children:  <Widget>[
                   const Text(
                     'Create your Own Category',
                     style: TextStyle(
                       color: Colors.white,
                       fontFamily: 'halter',
                       fontSize: 20,
                     ),
                   ),
                   const SizedBox(
                     height: 10,
                   ),
                   TextField(
                     controller: categoryController,
                     decoration: const InputDecoration(
                         hintText: "Enter Category",
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
                    validate(context,categoryController.text);
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
                         'Save Category',
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

  void validate(BuildContext context,String text) {
    final data = CategoryModal( category: text);
    final box = Boxes.getCategoryModal();
    box.add(data);
    Navigator.pop(context);
    print('valid!');
  }







