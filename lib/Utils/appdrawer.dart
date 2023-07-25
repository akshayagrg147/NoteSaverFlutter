// import 'package:flutter/material.dart';
//
//
// class AppDrawer extends StatelessWidget {
//   const AppDrawer({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           UserAccountsDrawerHeader(
//             accountName: Text('Note Saver App'),
//             accountEmail: Text('notesaver@gmail.com'),
//             currentAccountPicture: CircleAvatar(
//               backgroundColor: Colors.white70,
//               child: Image.asset("assets/images/avatar.png",width: 50,height: 50,),
//             ),
//             currentAccountPictureSize: Size(65,65),
//           ),
//           ListTile(
//             title: const Text('Account'),
//             onTap: () {
//               // TODO: Implement account tab.
//             },
//           ),
//           ListTile(
//             title: const Text('Security'),
//             onTap: () {
//               // TODO: Implement security tab.
//             },
//           ),
//           Container(
//             padding: const EdgeInsets.all(16.0),
//             child: const Text(
//               'spnix',
//               style: TextStyle(fontSize: 18.0),
//             ),
//           ),
//         ],
//       ),
//
//     );
//   }
// }