import 'package:flutter/material.dart';
import '../../notesfile/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ColorItems extends StatelessWidget {
  const ColorItems({super.key, required this.isActive, required this.color});

  final bool isActive;

  final Color color;
  @override
  Widget build(BuildContext context) {
    return isActive
        ? CircleAvatar(
            radius: 28,
            backgroundColor: Colors.black,
            child: CircleAvatar(
              radius: 26,
              backgroundColor: color,
            ),
          )
        : CircleAvatar(
            radius: 26,
            backgroundColor: color,
          );
  }
}

class ColorSelecting extends StatefulWidget {
  const ColorSelecting({super.key});

  @override
  State<ColorSelecting> createState() => _ColorSelectingState();
}

class _ColorSelectingState extends State<ColorSelecting> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 29 * 2,
      child: ListView.builder(
        itemCount: kColors.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: GestureDetector(
              onTap: () async {
                currentIndex = index;

                var sharedpref = await SharedPreferences.getInstance();
                sharedpref.setInt("selectedcolor", kColors[index].value);
                setState(() {});
              },
              child: ColorItems(
                color: kColors[index],
                isActive: currentIndex == index,
              ),
            ),
          );
        },
      ),
    );
  }
}
