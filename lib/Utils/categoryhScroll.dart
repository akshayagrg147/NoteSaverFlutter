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
      height: 75,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.only(right:8,top: 10,bottom: 8),
            child:InkWell(
                onTap: (){},
                child: Container(
                  width: 95,
                  // height: 48,
                  decoration: BoxDecoration(border: Border.all(width:3,color: Color(0xFFFfc9b6)),
                      borderRadius: BorderRadius.circular(30)
                      ),
                  child:Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:10.0,right: 11),
                        child: CircleAvatar(
                          radius: 18,
                            backgroundColor: Colors.orangeAccent,
                            child: Icon(Icons.category_outlined)),
                      ),
                      Text("All",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w400),),
                    ],
                  ),
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right:8,top: 11,bottom: 8),
            child:InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NoteScreen()),
                  );
                },
                child: Container(
                  width: 95,
                  decoration: BoxDecoration(border: Border.all(width:1,color: Colors.grey),
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child:Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:5.0,right: 5),
                        child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Color(0xfffaf3ed),
                            child: Icon(Icons.add_card)),
                      ),
                      Text("Card",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w400),),
                    ],
                  ),
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right:8,top: 11,bottom: 8),
            child:InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NoteScreen()),
                  );
                },
                child: Container(
                  width: 95,
                  decoration: BoxDecoration(border: Border.all(width:1,color: Colors.grey),
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child:Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:4.0,right:1),
                        child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Color(0xfffaf3ed),
                            child: Icon(Icons.note_add_outlined)),
                      ),
                      Text("Notes",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w400),),
                    ],
                  ),
                )
            ),
          ),




        ],
      ),
    );
  }
}