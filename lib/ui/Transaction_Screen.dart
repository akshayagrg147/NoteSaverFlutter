// import 'dart:io';
//
// import 'package:cardsaver/Utils/transaction_widgets/add_transaction_bottomsheet.dart';
// import 'package:cardsaver/models/boxes.dart';
// import 'package:cardsaver/models/notes_modal.dart';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../constants/transaction_constant.dart';
// import '../Utils/transaction_widgets/income_expense_card.dart';
// import '../Utils/transaction_widgets//transaction_tile.dart';
//
// class Transaction extends StatefulWidget {
//   const Transaction({Key? key}) : super(key: key);
//
//   @override
//   State<Transaction> createState() => _TransactionState();
// }
//
// class _TransactionState extends State<Transaction> {
//   String? firstname = "";
//   String? lastname = "";
//   String? profilePicPath = "";
//
//   @override
//   void initState() {
//     super.initState();
//     getUserName();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         floatingActionButton: FloatingActionButton(
//           backgroundColor: accent,
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const AddTransaction()),
//             );
//           },
//           child: const Icon(Icons.add),
//         ),
//         body: ValueListenableBuilder<Box<TransactionModal>>(
//             valueListenable: Boxes.gettransactiondata().listenable(),
//             builder: (context, box, _) {
//               var data = box.values.toList().cast<TransactionModal>();
//
//               return SafeArea(
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       children: [
//                         ListTile(
//                             leading: ClipRRect(
//                                 borderRadius: const BorderRadius.all(
//                                     Radius.circular(defaultRadius)),
//                                 child: profilePicPath != "" &&
//                                         profilePicPath != null
//                                     ? CircleAvatar(backgroundImage: FileImage(File("$profilePicPath")), radius: 28,)
//                                     : Image.asset("assets/images/avatar.png",
//                                         width: 50)),
//                             title: firstname == "" || firstname == null
//                                 ? Text("Hey, User!",
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .titleMedium
//                                         ?.copyWith(color: fontDark))
//                                 : Text("$firstname $lastname",
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .titleMedium
//                                         ?.copyWith(color: fontDark))),
//                         Center(
//                           child: Column(
//                             children: [
//                               const SizedBox(height: defaultSpacing / 2),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     vertical: defaultSpacing),
//                                 child: Text(
//                                     "₹${_totalIncome(data: data, length: box.length) - _totalExpense(data: data, length: box.length)}",
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .titleMedium
//                                         ?.copyWith(
//                                             color: fontHeading,
//                                             fontSize: fontSizeHeading + 2,
//                                             fontWeight: FontWeight.w800)),
//                               ),
//                               Text("Total Balance",
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .titleMedium
//                                       ?.copyWith(
//                                           color: fontSubHeading,
//                                           fontSize: fontSizeBody,
//                                           fontWeight: FontWeight.w600)),
//                               const SizedBox(
//                                 height: defaultSpacing * 2,
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Flexible(
//                                     child: IncomeExpenseCard(
//                                         bgColor: primaryDark,
//                                         label: "Income",
//                                         balance: _totalIncome(
//                                                 data: data, length: box.length)
//                                             .toString(),
//                                         icon: Icons.arrow_upward),
//                                   ),
//                                   const SizedBox(
//                                     width: defaultSpacing,
//                                   ),
//                                   Flexible(
//                                     child: IncomeExpenseCard(
//                                         bgColor: accent,
//                                         label: "Expenses",
//                                         balance:
//                                             "-${_totalExpense(data: data, length: box.length)}",
//                                         icon: Icons.arrow_downward),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(
//                                 height: defaultSpacing * 2,
//                               ),
//                               Align(
//                                   alignment: Alignment.bottomLeft,
//                                   child: Text(
//                                     "Recent transactions",
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .titleLarge
//                                         ?.copyWith(
//                                             color: fontHeading,
//                                             fontWeight: FontWeight.w600),
//                                   )),
//                               const SizedBox(
//                                 height: defaultSpacing * 2,
//                               ),
//                               ListView.builder(
//                                   physics: const NeverScrollableScrollPhysics(),
//                                   shrinkWrap: true,
//                                   itemCount: box.length,
//                                   itemBuilder: (context, index) {
//                                     // data[index].type == "Expense"
//                                     // ? totalExpense += data[index].amount
//                                     // : totalIncome += data[index].amount;
//                                     return TransactionTile(
//                                         transaction: data[index]);
//                                   })
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             }));
//   }
//
//   getUserName() async {
//     var sharedPrefProfileInfo = await SharedPreferences.getInstance();
//     setState(() {
//       firstname = sharedPrefProfileInfo.getString('firstname');
//       lastname = sharedPrefProfileInfo.getString('lastname');
//       profilePicPath = sharedPrefProfileInfo.getString('profilePicPath');
//     });
//   }
// }
//
// int _totalExpense({required data, required length}) {
//   int expense = 0;
//   for (int i = 0; i < data.length; i++) {
//     if (data[i].type == "Expense") {
//       expense = (expense + data[i].amount).toInt();
//     }
//   }
//   return expense;
// }
//
// int _totalIncome({required data, required length}) {
//   int income = 0;
//   for (int i = 0; i < data.length; i++) {
//     if (data[i].type == "Income") {
//       income = (income + data[i].amount).toInt();
//     }
//   }
//   return income;
// }
