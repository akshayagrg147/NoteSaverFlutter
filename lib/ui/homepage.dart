import 'package:cardsaver/Utils/SearchField.dart';
import 'package:cardsaver/Utils/categoryhScroll.dart';

import 'package:flutter/material.dart';
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

  ListView _horizontalList(int n) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: List.generate(
        n,
            (i) => Container(
          child: Text('Social $i'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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


 //add button
         // Align(alignment: Alignment.bottomRight,
         // child: IconButton(
         //   padding: EdgeInsets.all(10),
         //    icon: const Icon(Icons.add),
         //    iconSize: 50,
         //    onPressed: () {
         //      Navigator.push(
         //        context,
         //        MaterialPageRoute(builder: (context) => FirstRoute()),
         //      );
         //    },
         //  ),
         //  ),


        ],
    ),
        ),
          ],
        ),
      ),
    );
  }
}






