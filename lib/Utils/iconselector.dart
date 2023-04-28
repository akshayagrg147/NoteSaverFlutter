import 'package:flutter/material.dart';
import '../../notesfile/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IconItems extends StatelessWidget {
  const IconItems({super.key, required this.isActive, required this.icon});

  final bool isActive;

  final String icon;
  @override
  Widget build(BuildContext context) {
    return isActive
        ? CircleAvatar(
            radius: 28,
            backgroundColor: Colors.black,
            child: CircleAvatar(
              backgroundImage: AssetImage(icon),
              backgroundColor: const Color(0xFFFff6f1),
              radius: 26,
            ),
          )
        : CircleAvatar(
      radius: 28,
          backgroundColor: Colors.transparent,
          child: CircleAvatar(
              radius: 26,
              backgroundImage: AssetImage(icon),
              backgroundColor: Colors.transparent,
            ),
        );
  }
}

class IconSelecting extends StatefulWidget {
  const IconSelecting({super.key});

  @override
  State<IconSelecting> createState() => _IconSelectingState();
}

class _IconSelectingState extends State<IconSelecting> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 29 * 2,
      child: ListView.builder(
        itemCount: kIcons.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: GestureDetector(
              onTap: () async {
                currentIndex = index;
                var sharedpref = await SharedPreferences.getInstance();
                sharedpref.setString("selectedicon", kIcons[index]);
                setState(() {});
              },
              child: IconItems(
                icon: kIcons[index],
                isActive: currentIndex == index,
              ),
            ),
          );
        },
      ),
    );
  }
}
