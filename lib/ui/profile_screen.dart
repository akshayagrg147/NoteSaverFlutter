import 'package:cardsaver/ui/privacy_setting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cardsaver/ui/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? firstname = "";
  String? lastname = "";
  String? email = "";
  String? profilePicPath = "";

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

  @override
  void initState() {
    super.initState();
    getProfileInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(LineAwesomeIcons.angle_left),
          color: Colors.black,
        ),
        title: const Text("Profile",
            style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.w500)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(LineAwesomeIcons.sun),
            color: Colors.black,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: Center(
                        child: profilePicPath != ""
                            ? CircleAvatar(
                                backgroundImage:
                                    FileImage(File(profilePicPath!)),
                                radius: 200.0,
                              )
                            : const CircleAvatar(
                          radius: 200,
                          backgroundColor: Colors.black,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 58,
                            child: Padding(
                              padding: EdgeInsets.only(left: 18),
                              child: Text(
                                'No image selected',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ),
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
                        onPressed: (){
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
              const SizedBox(height: 10),
              firstname == ""
                  ? const Text("Enter name",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 19))
                  : Text("$firstname $lastname",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 19)),
              const SizedBox(height: 1),
              email == ""
                  ? const Text("Enter your email address",
                      style: TextStyle(fontSize: 15))
                  : Text(email!, style: const TextStyle(fontSize: 15)),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UpdateProfileScreen(),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFE400),
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text("Edit Profile",
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                  title: "Account",
                  icon: LineAwesomeIcons.user_1,
                  onPress: () {}),
              ProfileMenuWidget(
                  title: "Privacy Setting",
                  icon: LineAwesomeIcons.cog,
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PrivacySetting(),
                        ));
                  }),
              ProfileMenuWidget(
                  title: "Contact Us",
                  icon: LineAwesomeIcons.info,
                  onPress: () {}),
              const Divider(color: Colors.grey),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                  title: "Information",
                  icon: LineAwesomeIcons.info,
                  onPress: () {}),
              ProfileMenuWidget(
                  title: "Logout",
                  icon: LineAwesomeIcons.alternate_sign_out,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
    super.key,
  });
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    var iconColor = const Color(0xFF001BFF);

    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: iconColor.withOpacity(0.1),
        ), // BoxDecoration
        child: Icon(icon, color: iconColor),
      ), // Container
      title: Text(title,
          style:
              Theme.of(context).textTheme.bodyLarge?.apply(color: textColor)),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: const Icon(LineAwesomeIcons.angle_right,
                  size: 18, color: Colors.grey))
          : null,
    );
  }
}
