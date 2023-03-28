import 'package:cardsaver/constants.dart';
import 'package:cardsaver/notesave/noteScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

          backgroundColor: Colors.deepPurple,
          leading: IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Menu',
            onPressed: () {},
          ), //IconButton
          actions: <Widget>[
            //IconButton
            IconButton(
              icon: Icon(Icons.person),
              tooltip: 'Person',
              onPressed: () {},
            ), //IconButton
          ], //<Widget>[]
        ),
      body: CustomScrollView(
        slivers: [

      SliverList(
      delegate: SliverChildListDelegate(
      [
        Expanded(child: SearchField()),
        // Container(
        //   width: double.infinity,
        //   height: 50,
        //   color: Colors.deepPurple,
        //
        //   child: Center(
        //     child: Text(
        //       'Header',
        //       style: TextStyle(color: Colors.white, letterSpacing: 4),
        //     ),
        //   ),
        // ),
        // ListView(
        //   scrollDirection: Axis.horizontal,
        //   children: <Widget>[
        //     Container(
        //       width: 150.0,
        //       color: Colors.red,
        //     ),
        //     Container(
        //       width: 150.0,
        //       color: Colors.blue,
        //     ),
        //     Container(
        //       width: 150.0,
        //       color: Colors.green,
        //     ),
        //   ],
        // ),

        ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/devs.jpg',
                        width: 50,
                        height: 50,
                      )
                    ,
                      Spacer(),
                      Column(
                        children: const [
                          Text('Google', style: TextStyle(color: Colors.black54)),
                          Text('com.google.package', style: TextStyle(color: Colors.black54)),
                        ],
                      ),
                      Spacer(),
                      Image.asset(
                        'assets/images/devs.jpg',
                        width: 50,
                        height: 50,
                      )
                    ],
                  )


              ),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.add),
          iconSize: 50,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FirstRoute()),
            );
          },
        ),
      ],

    ),
      ),

        ],

      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
      child: TextFormField(
        autofocus: false,
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

Widget topBar() {
  return AppBar(

    backgroundColor: Colors.deepPurple,
    leading: IconButton(
      icon: Icon(Icons.menu),
      tooltip: 'Menu',
      onPressed: () {},
    ), //IconButton
    actions: <Widget>[
      //IconButton
      IconButton(
        icon: Icon(Icons.person),
        tooltip: 'Person',
        onPressed: () {},
      ), //IconButton
    ], //<Widget>[]
  );
}

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
