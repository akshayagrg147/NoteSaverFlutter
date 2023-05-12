import 'package:cardsaver/ui/notes_screen_ui/notes_view.dart';
import 'package:cardsaver/ui/savedCardScreen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HorizontalScroll extends StatefulWidget {
  const HorizontalScroll({Key? key}) : super(key: key);

  @override
  State<HorizontalScroll> createState() => _HorizontalScrollState();
}

class _HorizontalScrollState extends State<HorizontalScroll> {
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
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
                  decoration: BoxDecoration(border: Border.all(width:3,color: const Color(0xFFFfc9b6)),
                      borderRadius: BorderRadius.circular(30)
                      ),
                  child:Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left:10.0,right: 11),
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
                  _launchURL();
                },
                child: Container(
                  width: 114,
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
                            backgroundColor: const Color(0xfffaf3ed),
                            child: Image.asset("assets/images/chat_logo.png")),
                      ),
                      const Text("ChatGpt",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w400),),
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
                            backgroundColor: const Color(0xfffaf3ed),
                            child: Image.asset("assets/images/card.png")),
                      ),
                      const Text("Card",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w400),),
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
                    MaterialPageRoute(builder: (context) => const NotesView()),
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
                            backgroundColor: const Color(0xfffaf3ed),
                            child: Image.asset("assets/images/notes.png")),
                      ),
                      const Text("Notes",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w400),),
                    ],
                  ),
                )
            ),
          ),




        ],
      ),
    );
  }

  _launchURL() async {
    const url = 'https://chat.openai.com';
    final uri = Uri.parse(url);
      await launchUrl(uri,mode: LaunchMode.externalApplication);

    // if (await canLaunchUrl(uri)) {
    //   await launchUrl(uri);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }
}