import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrivacySetting extends StatefulWidget {
  const PrivacySetting({Key? key}) : super(key: key);

  @override
  State<PrivacySetting> createState() => _PrivacySettingState();
}

class _PrivacySettingState extends State<PrivacySetting> {
  bool onOff = false;

  getFingerPrintOnOff() async {
    var sharedpref = await SharedPreferences.getInstance();
    setState(() {
      onOff = sharedpref.getBool("fingerprint_on_off")!;
    });
  }
  setFingerPrintOnOff() async {
    var sharedpref = await SharedPreferences.getInstance();
    sharedpref.setBool("fingerprint_on_off", onOff);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getFingerPrintOnOff();
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
        title: const Text("Setting",
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
      body: Column(
        children: [
          Card(
            child: ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color(0xFF001BFF).withOpacity(0.1),
                ), // BoxDecoration
                child: Icon(LineAwesomeIcons.fingerprint,
                    color: Color(0xFF001BFF)),
              ),
              title: Text("Fingerprint Authentication",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.apply(color: Colors.black)),
              trailing: Switch(
                value: onOff,
                activeColor: Color(0xFF001BFF).withOpacity(0.9),
                onChanged: (bool value) {
                  setState(() {
                    onOff = value;
                  });
                  setFingerPrintOnOff();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

}
