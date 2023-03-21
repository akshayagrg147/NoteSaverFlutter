import 'package:cardsaver/notesave/noteScreen.dart';
import 'package:flutter/material.dart';

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
            delegate: SliverChildBuilderDelegate(
    (BuildContext context, int index) {
    return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Container(
    color: Colors.pink[100],
    height: 40,
    alignment: Alignment.center,
    child: Text(
    "$index",
    style: const TextStyle(fontSize: 30),
    ),
    ),
    );
    },
    // 40 list items
    childCount: 10,
    ),

    ),

        ],
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
