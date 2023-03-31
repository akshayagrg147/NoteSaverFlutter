import 'package:cardsaver/constants.dart';
import 'package:cardsaver/notesave/noteScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';

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
          Expanded(child:SearchField()), SizedBox(height: 20,),
          hScroll(), SizedBox(height: 20,),
          Align(
           alignment: Alignment.bottomRight,
           child:ElevatedButton.icon(
             style: ButtonStyle(
               backgroundColor: MaterialStateProperty.all(Colors.transparent),
             ),
             onPressed: () {},
             icon: Icon( // <-- Icon
               Icons.sort_rounded,
               size: 14.0,
               color: Colors.blue,
             ),
             label: Text('Sortby'), // <-- Text
           ),
         ),

          SizedBox(height: 20,),
          ListView.builder(
            shrinkWrap: true,
            itemCount: languages.length,
            itemBuilder: (BuildContext context,  index) {
              return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                margin: EdgeInsets.only(left: 20, right: 20 ,top: 10,bottom: 10),
                child:  ListTile(

                    contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                    shape: RoundedRectangleBorder( //<-- SEE HERE
                      side: BorderSide(width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: Text('${languages[index].name}',style: TextStyle(color: Colors.black),),

                    subtitle: Text(".compackage",style: TextStyle(color: Colors.black),),

                    leading: CircleAvatar(backgroundImage: AssetImage("assets/images/$index.png")),
                    trailing: Icon(Icons.copy_all,color: Colors.black,),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FirstRoute()),
                      );
                    },


                  ),
              );
            },

          ),


 //add button
          Align(alignment: Alignment.bottomRight,
         child: IconButton(
           padding: EdgeInsets.all(10),
            icon: const Icon(Icons.add),
            iconSize: 50,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FirstRoute()),
              );
            },
          ),
          ),


        ],
    ),
        ),
          ],
        ),
      ),
    );
  }
}



//scroll view
class hScroll extends StatefulWidget {
  const hScroll({Key? key}) : super(key: key);

  @override
  State<hScroll> createState() => _hScrollState();
}

class _hScrollState extends State<hScroll> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:InkWell(
                onTap: (){},
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),
                  child:Center( child: Text("All category",style: TextStyle(fontSize: 10,color: Colors.black),),),
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:InkWell(
                onTap: (){},
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),
                  child:Center( child: Text("Passwords",style: TextStyle(fontSize: 10,color: Colors.black),),),
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:InkWell(
                onTap: (){},
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),
                  child:Center( child: Text("Personal Information",style: TextStyle(fontSize: 10,color: Colors.black),),),
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:InkWell(
                onTap: (){},
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),
                  child:Center( child: Text("Emails",style: TextStyle(fontSize: 10,color: Colors.black),),),
                )
            ),
          ),Padding(
            padding: const EdgeInsets.all(8.0),
            child:InkWell(
                onTap: (){},
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),
                  child:Center( child: Text("Addresses",style: TextStyle(fontSize: 10,color: Colors.black),),),
                )
            ),
          ),


        ],
      ),
    );
  }
}

//search field
class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
      child: TextFormField(
        autofocus: true,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: "Search Passwords",
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          prefixIcon:
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ),
      ),
    );
  }
}

//navigation
class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),

      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('ADD'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FirstRoute()),
            );
          },
        ),
      ),
    );
  }
}

//Global declarations
class Language {
  String name;
  bool isChecked;
  Language(this.name, {this.isChecked = false});

}

final List<Language> languages = [Language('Twiiter') ,Language('Google'),  Language('instagram') , Language('Github'),Language('Slack'),Language('Linkedin')];

