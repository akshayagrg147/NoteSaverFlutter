import 'package:cardsaver/SocialNotesPage/SocialCategory.dart';
// import 'package:cardsaver/Utils/SearchField.dart';
import 'package:cardsaver/Utils/categoryhScroll.dart';
import 'package:cardsaver/notesave/boxes.dart';
import 'package:cardsaver/notesave/notes_modal.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  double height = 0, width = 0;
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // #2 start here
  String search = '';
  TextEditingController searchController = TextEditingController();

  // #2 end here


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
        key: scaffoldKey,
          appBar: AppBar(
            elevation: 0,
            // backgroundColor: Colors.black26,
            backgroundColor: Color(0xFF4e3974),
            leading: IconButton(
              icon: const Icon(Icons.access_alarm),
              tooltip: 'Menu',
              onPressed: () {
                // if(scaffoldKey.currentState!.isDrawerOpen){
                //   scaffoldKey.currentState!.closeDrawer();
                //   //close drawer, if drawer is open
                // }else{
                // scaffoldKey.currentState!.openDrawer();
                // //open drawer, if drawer is closed
                // }
              },
            ), //IconButton
            actions: const <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 10,top: 10),
                child: CircleAvatar(backgroundImage: AssetImage("assets/images/avatar.png"),
                backgroundColor: Colors.red,
                radius: 28,),
              ),
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
                  child: Image.asset(
          'assets/images/facebook.png',
            height: 48,
            width: 48,
          ),
                  label: 'Facebook',
                  backgroundColor: Colors.blue,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SocialScreen("facebook")),
                    );
                  }
              ),
              SpeedDialChild(
                  child: Image.asset(
                    'assets/images/instagram.png',
                    height: 48,
                    width: 48,
                  ),
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
                  child: Image.asset(
                    'assets/images/others.png',
                    height: 48,
                    width: 48,
                  ),
                  label: 'Others',
                  onTap: () {
                    callBottomSheet(context);
                  }
              ),
            ],
          ),
          body: Container(

            decoration: const BoxDecoration(
              color: Color(0xFF4e3974),
              // borderRadius: BorderRadius.circular(20),
            ),

            child: ValueListenableBuilder<Box<CategoryModal>>(
                valueListenable: Boxes.getCategoryModal().listenable(),
                builder: (context, box, _) {
                  var data = box.values.toList().cast<CategoryModal>();
                  return Column(
                    children: [
                      // const SearchField(),
                      // #1 start here
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20,top: 25),
                        child: SizedBox(
                          height: 44,
                          child: TextFormField(
                            controller: searchController,
                            autofocus: false,
                            style: const TextStyle(color: Colors.black),
                            // #3starr here
                            onChanged: (String? value){
                              // print(value);
                              setState(() {
                                search = value.toString();
                              });
                              // #3 end here
                          },
                            decoration: InputDecoration(
                              contentPadding:
                              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                              hintText: 'Search "passwords"',
                              hintStyle: TextStyle(color: Colors.grey),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.7),
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              prefixIcon:
                              Icon(Icons.search,color: Colors.grey,),

                            ),
                          ),
                        ),
                      ),
                      // #1 end here

                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: const hScroll(),
                      ),
                      const SizedBox(height: 10,),
                      Expanded(
                        child:        ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: box.length,
                            itemBuilder: (context, index) {
                              late String position = data[index].category;

                              if(searchController.text.isEmpty){
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
                                        horizontal: 20.0,vertical: 0.0),
                                    shape: RoundedRectangleBorder( //<-- SEE HERE
                                      side: const BorderSide(width: 2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    title: Text(data[index].category,
                                      style: const TextStyle(color: Colors.black),),
                                    leading: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.blueAccent,
                                      child: Text((index+1).toString(),  style: const TextStyle(color: Colors.black,fontSize: 18),),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              final Map<dynamic, CategoryModal> deliveriesMap = box.toMap();
                                              dynamic desiredKey;
                                              deliveriesMap.forEach((key, value){
                                                if (value.category == box.values.take(index+1).first.category) {
                                                  desiredKey = key;
                                                }
                                              });

                                              box.delete(desiredKey);}, icon: const Icon(Icons.delete,color: Colors.black,)),

                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SocialScreen(data[index].category)),
                                      );

                                    },


                                  ),
                                );
                              }else if(position.toLowerCase().contains(searchController.text.toLowerCase())){
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
                                    title: Text(position,
                                      style: const TextStyle(color: Colors.black),),
                                    leading: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.blueAccent,
                                      child: Text((index+1).toString(),  style: const TextStyle(color: Colors.black,fontSize: 18),),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              final Map<dynamic, CategoryModal> deliveriesMap = box.toMap();
                                              dynamic desiredKey;
                                              deliveriesMap.forEach((key, value){
                                                if (value.category == box.values.take(index+1).first.category) {
                                                  desiredKey = key;
                                                }
                                              });

                                              box.delete(desiredKey);}, icon: const Icon(Icons.delete,color: Colors.black,)),

                                      ],
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SocialScreen(data[index].category)),
                                      );

                                    },


                                  ),
                                );

                                    // #5 code here
                                //   Container(
                                //   height: 100,
                                //   color: Colors.red,
                                // );
                                // #5 code end here

                              }else {
                                return Container();
                              }

                              // #4 start here original code
                              // return Container(
                              //   decoration: BoxDecoration(
                              //     color: Colors.white,
                              //     borderRadius: BorderRadius.circular(20),
                              //   ),
                              //   margin: const EdgeInsets.only(left: 20,
                              //       right: 20,
                              //       top: 10,
                              //       bottom: 10),
                              //   child: ListTile(
                              //
                              //     contentPadding: const EdgeInsets.symmetric(
                              //         horizontal: 20.0),
                              //     shape: RoundedRectangleBorder( //<-- SEE HERE
                              //       side: const BorderSide(width: 2),
                              //       borderRadius: BorderRadius.circular(20),
                              //     ),
                              //     title: Text(data[index].category,
                              //       style: const TextStyle(color: Colors.black),),
                              //     leading: CircleAvatar(
                              //       radius: 20,
                              //       backgroundColor: Colors.blueAccent,
                              //       child: Text((index+1).toString(),  style: const TextStyle(color: Colors.black,fontSize: 18),),
                              //     ),
                              //     trailing: Row(
                              //       mainAxisSize: MainAxisSize.min,
                              //       children: [
                              //         IconButton(
                              //             onPressed: () {
                              //               final Map<dynamic, CategoryModal> deliveriesMap = box.toMap();
                              //               dynamic desiredKey;
                              //               deliveriesMap.forEach((key, value){
                              //                 if (value.category == box.values.take(index+1).first.category) {
                              //                   desiredKey = key;
                              //                 }
                              //               });
                              //
                              //               box.delete(desiredKey);}, icon: const Icon(Icons.delete,color: Colors.black,)),
                              //
                              //       ],
                              //     ),
                              //     onTap: () {
                              //       Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) => SocialScreen(data[index].category)),
                              //       );
                              //
                              //     },
                              //
                              //
                              //   ),
                              // );
                              // #4 end here original code

                            }
                        ),
                      )

                    ],
                  );
                }
            )


      ),)
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
               color: Color(0xFF4e3974),
               borderRadius: BorderRadius.circular(20),
             ),
             height: 220,
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
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: TextField(
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
                   ),

                   const SizedBox(
                     height: 2,
                   ),

                   GestureDetector(
                     onTap: (){
                    validate(context,categoryController.text);
                     },
                     child: Container(
                       margin: const EdgeInsets.symmetric(
                           horizontal: 60, vertical: 6),
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
    // print('valid!');
  }







