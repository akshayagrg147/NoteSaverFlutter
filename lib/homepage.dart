import 'package:flutter/material.dart';
import 'package:cardsaver/addpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  double height = 0 , width = 0;

  @override
  Widget build(BuildContext context) {
    height =  MediaQuery.of(context).size.height;
    width =  MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Column(  children: [

            //profilecard
            Align(
                alignment: AlignmentDirectional.topEnd,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.yellow[100],
                    border: Border.all(
                      color: Colors.green,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(50),),
                  height: 90,
                  width: 90,
                  child: CircleAvatar(
                    child: Column(
                      children: [
                        Container(
                            width: 50,
                            child: Image.asset('lib/3.png')) ,
                        Text("Name",style: TextStyle(color: Colors.yellow),)
                      ],
                    ),
                    backgroundColor: Colors.black,
                    maxRadius: 50,
                  ),
                )
            ),

//container 1

            Container(
              height: height *.35,
              child: Text("Welcome Homepage\n\nRose Poole",style: TextStyle(color: Colors.black,fontSize: 20)),

              decoration: BoxDecoration(

              ),
              margin: const EdgeInsets.fromLTRB(0, 12.3, 200, 0),
            ),


            //cotainer 2

            Container(

              height: height *.5,

              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: ElevatedButton(
                child: const Text('ADD'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  FirstRoute()),
                  );
                },
              ),
            )

          ],
          )
        ],
      ),
    );
  }
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
              MaterialPageRoute(builder: (context) =>  FirstRoute()),
            );
          },
        ),
      ),
    );
  }
}
