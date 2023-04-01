import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class SocialScreen extends StatefulWidget {
  const SocialScreen({Key? key}) : super(key: key);

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        if(isDialOpen.value){
          isDialOpen.value = false;
          return false;
        }else{
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Social Route'),

        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          openCloseDial: isDialOpen,
          backgroundColor: Colors.redAccent,
          overlayColor: Colors.grey,
          overlayOpacity: 0.5,
          spacing: 15,
          spaceBetweenChildren: 15,
          // closeManually: true,
          children: [
            SpeedDialChild(
                child: Icon(Icons.local_atm),
                label: 'Credit/Debit Cards',
                backgroundColor: Colors.blue,
                onTap: (){

                }
            ),
            SpeedDialChild(
                child: Icon(Icons.lock),
                label: 'Passwords',
                onTap: (){
                  print('Mail Tapped');
                }
            ),

            SpeedDialChild(
                child: Icon(Icons.person),
                label: 'Personal Info',
                onTap: (){
                  print('Copy Tapped');
                }
            ),
          ],
        ),
        body: Container(
          alignment: Alignment.center,
          child: const Text("Notes",style: TextStyle(fontSize: 30),),
        ),
      ),
    );
  }
}