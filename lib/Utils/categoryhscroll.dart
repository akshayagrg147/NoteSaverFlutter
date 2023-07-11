import 'package:cardsaver/Utils/chatgpt_webview.dart';
import 'package:cardsaver/ui/Transaction_Screen.dart';
import 'package:cardsaver/ui/document.dart';
import 'package:cardsaver/ui/image_resize.dart';
import 'package:cardsaver/ui/notes_screen_ui/notes_view.dart';
import 'package:cardsaver/ui/savedCardScreen.dart';
import 'package:flutter/material.dart';

class HorizontalScroll extends StatefulWidget {
  const HorizontalScroll({Key? key}) : super(key: key);

  @override
  State<HorizontalScroll> createState() => _HorizontalScrollState();
}

class _HorizontalScrollState extends State<HorizontalScroll> {

  final List<CategoryModel> _data = [
    CategoryModel("assets/images/chat_logo.png", "ChatGpt", MyChatGpt()),
  CategoryModel("assets/images/wallet.png", "Wallet", Transaction()),
  CategoryModel("assets/images/resizer.png", "Resize Image", ImageResizer()),
  CategoryModel("assets/images/document.png", "Docs", SaveDocument()),
  CategoryModel("assets/images/card.png", "Card", NoteScreen()),
  CategoryModel("assets/images/notes.png", "Notes", NotesView())

  ];


  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 55,

        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
          return customRow(_data[index], () => {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => _data[index].widget),
          )
          });
        }, itemCount: _data.length,)


    );
  }
}

Widget customRow(CategoryModel data,
    Function() onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.only(left: 10.0),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
                radius: 18,
                backgroundColor: const Color(0xfffaf3ed),
                child: Image.asset(data.icon)),
            SizedBox(width: 10,),
            Text(data.title, style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w400),)
          ],
        ),
      ),
    )
    ,
  );
}

class CategoryModel {
  final String icon;
  final String title;
  final Widget widget;

  CategoryModel(this.icon, this.title, this.widget);
}