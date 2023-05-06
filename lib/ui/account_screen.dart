import 'package:cardsaver/ui/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import '../models/boxes.dart';

class AccountSection extends StatefulWidget {
  const AccountSection({Key? key}) : super(key: key);

  @override
  State<AccountSection> createState() => _AccountSectionState();
}

class _AccountSectionState extends State<AccountSection> {
  String? firstname = "";
  String? lastname = "";
  String? email = "";
  String? profilePicPath = "";
  ImageProvider imageChose = const AssetImage("assets/images/noselectedimage.png");

  getProfileInfo() async {
    var sharedPrefProfileInfo = await SharedPreferences.getInstance();
    setState(() {
      firstname = sharedPrefProfileInfo.getString('firstname');
      lastname = sharedPrefProfileInfo.getString('lastname');
      email = sharedPrefProfileInfo.getString('email');
    });
    setState(() {
      profilePicPath = sharedPrefProfileInfo.getString('profilePicPath');
    });
  }

  void choseImage() {
    if (profilePicPath != "" && profilePicPath != null) {
      setState(() {
        imageChose = FileImage(File("$profilePicPath"));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getProfileInfo();
    choseImage();
    return Scaffold(
      backgroundColor: const Color(0xFFf4f4f4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFf4f4f4),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(LineAwesomeIcons.angle_left),
          color: Colors.black,
        ),
        title: const Text("Account",
            style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.w500)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                      // color: Colors.green,
                      borderRadius: BorderRadius.circular(80),
                      image: DecorationImage(
                        image: imageChose,
                      )
                      //more than 50% of width makes circle
                      ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: const Color(0xFFFFE400)),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UpdateProfileScreen(),
                            ));
                      },
                      icon: const Icon(
                        LineAwesomeIcons.alternate_pencil,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            firstname == "" || firstname == null
                ? const SectionWidget(title: "Name", subtitle: "Update Profile!")
                : SectionWidget(
                    title: "Name", subtitle: "$firstname $lastname"),
            firstname == "" || firstname == null
                ? const SectionWidget(title: "Email", subtitle: "Update Profile!")
                : SectionWidget(title: "Email", subtitle: "$email"),

            SectionWidget(title: "Passwords Saved", subtitle:passwordSaved().toString() ),
            SectionWidget(title: "Cards Saved", subtitle: cardSaved().toString()),
            // SectionWidget(title: "Notes Saved", subtitle: "Update Profile!"),
          ],
        ),
      ),
    );
  }

  int cardSaved() {
    final box = Boxes.getdata();
    return box.length;
  }
  int passwordSaved() {
    final box = Boxes.getgooglePasswords();
    final box1 = Boxes.getInstagramPasswords();
    final box2 = Boxes.getFacebookPasswords();
    final box3 = Boxes.getSocialPasswords();
    final box4 = Boxes.getBankingPasswords();
    return box.length +box1.length +box2.length +box3.length + box4.length;
  }
}

class SectionWidget extends StatelessWidget {
  const SectionWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            title: Text(
              title,
              style: const TextStyle(color: Colors.grey),
            ),
            subtitle: Text(subtitle,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16))),
        const Divider(color: Colors.grey),
      ],
    );
  }
}
