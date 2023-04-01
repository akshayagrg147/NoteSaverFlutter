import 'package:cardsaver/SocialNotesPage/SocialCategory.dart';
import 'package:cardsaver/ui/savedCardScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                  child:const Center( child: Text("All category",style: TextStyle(fontSize: 10,color: Colors.black),),),
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NoteScreen()),
                  );
                },
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),
                  child:const Center( child: Text("Credit Cards",style: TextStyle(fontSize: 10,color: Colors.black),),),
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:InkWell(
                onTap: (){},
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),
                  child:const Center( child: Text("Personal Information",style: TextStyle(fontSize: 10,color: Colors.black),),),
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
                  child:const Center( child: Text("Emails",style: TextStyle(fontSize: 10,color: Colors.black),),),
                )
            ),
          ),Padding(
            padding: const EdgeInsets.all(8.0),
            child:InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SocialScreen()),
                  );
                },
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),
                  child:const Center( child: Text("Social",style: TextStyle(fontSize: 10,color: Colors.black),),),
                )
            ),
          ),


        ],
      ),
    );
  }
}