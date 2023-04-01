import 'package:cardsaver/SocialNotesPage/SocialCategory.dart';
import 'package:cardsaver/Utils/SearchField.dart';
import 'package:cardsaver/Utils/categoryhScroll.dart';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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
      onWillPop: () async{
        if(isDialOpen.value){
          isDialOpen.value = false;
          return false;
        }else{
          return true;
        }
      },
      child: Scaffold(
          appBar:  AppBar(

            backgroundColor: Colors.purple[900],
            leading: IconButton(
              icon: Icon(Icons.menu),
              tooltip: 'Menu',
              onPressed: () {},
            ), //IconButton
            actions: <Widget>[
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
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  SocialScreen()),
                  );
                }
            ),
            SpeedDialChild(
                child: Icon(Icons.lock),
                label: 'Instagram',
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  SocialScreen()),
                  );
                }
            ),

            SpeedDialChild(
                child: Icon(Icons.person),
                label: 'NetBanking',
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  SocialScreen()),
                  );
                }
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.purple[900]
          ),
          child: CustomScrollView(
            slivers:
            [SliverList
              (delegate:
                SliverChildListDelegate(
            [
            const Expanded(child:SearchField()),
              const SizedBox(height: 20,),
              const hScroll(),
              const SizedBox(height: 20,),
            ListView.builder(
              shrinkWrap: true,
              itemCount: languages.length,
              itemBuilder: (BuildContext context,  index) {
                return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                  margin: const EdgeInsets.only(left: 20, right: 20 ,top: 10,bottom: 10),
                  child:  ListTile(

                      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                      shape: RoundedRectangleBorder( //<-- SEE HERE
                        side: const BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      title: Text('${languages[index].name}',style: TextStyle(color: Colors.black),),

                      subtitle: Text(".compackage",style: TextStyle(color: Colors.black),),

                      leading: CircleAvatar(backgroundImage: AssetImage("assets/images/$index.png")),
                      trailing: Icon(Icons.copy_all,color: Colors.black,),
                      onTap: (){

                      },


                    ),
                );
              },

            ),



          ],
      ),
          ),
            ],
          ),
        ),
      ),
    );
  }
}






