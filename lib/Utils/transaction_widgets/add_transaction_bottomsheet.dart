// import 'package:cardsaver/models/boxes.dart';
// import 'package:cardsaver/models/notes_modal.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
// import 'package:line_awesome_flutter/line_awesome_flutter.dart';
//
// class AddTransaction extends StatefulWidget {
//   const AddTransaction({Key? key}) : super(key: key);
//
//   @override
//   State<AddTransaction> createState() => _AddTransactionState();
// }
//
// class _AddTransactionState extends State<AddTransaction> {
//   final GlobalKey<FormState> formKey = GlobalKey();
//   String? category;
//   String? types = "Expense";
//   String? transactionType;
//   var titleController = TextEditingController();
//   var descriptionController = TextEditingController();
//   var amountController = TextEditingController();
//   TextEditingController dateinput = TextEditingController();
//   final List<Widget> transactiontype = <Widget>[const Text("Expense"), const Text("Income")];
//   final List<bool> _selectedtype = <bool>[true, false];
//
//
//
//   void dispose() {
//     // print("dispose");
//     titleController.dispose();
//     descriptionController.dispose();
//     amountController.dispose();
//     super.dispose();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFf4f4f4),
//         centerTitle: true,
//         title: const Text("Add Transaction",
//             style: TextStyle(
//                 fontSize: 22,
//                 color: Colors.black,
//                 fontWeight: FontWeight.w500)),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(LineAwesomeIcons.angle_left),
//           color: Colors.black,
//         ),
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Form(
//           key: formKey,
//           child: Column(
//             children: [
//               ToggleButtons(
//                 onPressed: (int index) {
//                   setState(() {
//                     for (int i = 0; i < _selectedtype.length; i++) {
//                       _selectedtype[i] = i == index;
//                     }
//                     if(index==0 && _selectedtype[index]){
//                       types = "Expense";
//                     }
//                     else if (index==1 && _selectedtype[index]){
//                       types = "Income";
//
//                     }
//                   });
//                 },
//                 borderRadius: const BorderRadius.all(Radius.circular(8)),
//                 selectedBorderColor: Colors.red[700],
//                 selectedColor: Colors.white,
//                 fillColor: Colors.red[200],
//                 color: Colors.red[400],
//                 constraints: const BoxConstraints(
//                   minHeight: 40.0,
//                   minWidth: 80.0,
//                 ),
//                 isSelected: _selectedtype,
//                 children: transactiontype,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 16, top: 12, right: 16),
//                 child: DropdownButtonFormField(
//                     items: <String>[
//                       "Payment",
//                       "Flipkart",
//                       "Amazon",
//                       "Chroma",
//                       "Offline",
//                       "Emi",
//                       "Others",
//                     ].map((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(
//                           value,
//                           style: const TextStyle(
//                             fontSize: 14,
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Colors.grey.withOpacity(0.7),
//                           width: 2,
//                         ),
//                         borderRadius: const BorderRadius.all(Radius.circular(30)),
//                       ),
//                       labelText:
//                           (category != null ? "Category" : "Select Category"),
//                     ),
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         category = newValue!;
//                       });
//                     },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter some text';
//                     }
//                     return null;
//                   },),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
//                 child: TextFormField(
//                   controller: titleController,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         color: Colors.grey.withOpacity(0.7),
//                         width: 2,
//                       ),
//                       borderRadius: const BorderRadius.all(Radius.circular(30)),
//                     ),
//
//                     labelText: 'Title',
//                     labelStyle: const TextStyle(fontSize: 14),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter some text';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
//                 child: TextFormField(
//                   controller: descriptionController,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         color: Colors.grey.withOpacity(0.7),
//                         width: 2,
//                       ),
//                       borderRadius: const BorderRadius.all(Radius.circular(30)),
//                     ),
//                     labelText: 'Description',
//                     labelStyle: const TextStyle(fontSize: 14),
// // errorText: (bankNameController.toString().isNotEmpty ? "Please input a valid nae" : null),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter some text';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
//                 child: TextFormField(
//                   keyboardType: TextInputType.number,
//                   inputFormatters: <TextInputFormatter>[
//                     FilteringTextInputFormatter.digitsOnly
//                   ],
//                   controller: amountController,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         color: Colors.grey.withOpacity(0.7),
//                         width: 2,
//                       ),
//                       borderRadius: const BorderRadius.all(Radius.circular(30)),
//                     ),
//                     labelText: 'Amount',
//                     labelStyle: const TextStyle(fontSize: 14),
//
// // errorText: (bankNameController.toString().isNotEmpty ? "Please input a valid nae" : null),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter amount';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: TextFormField(
//                   controller: dateinput, //editing controller of this TextField
//                   decoration: InputDecoration(
//                       prefixIcon: const Icon(Icons.calendar_today), //icon of text field
//                       labelText: "Enter Date" , //label text of field
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide(
//                         color: Colors.grey.withOpacity(0.7),
//                         width: 2,
//                       ),
//                       borderRadius: const BorderRadius.all(Radius.circular(30)),
//                     ),
//                       ),
//                   readOnly:
//                       true,
//                   onTap: () async {
//                     DateTime? pickedDate = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(
//                             2000), //DateTime.now() - not to allow to choose before today.
//                         lastDate: DateTime(2101));
//
//                     if (pickedDate != null) {
//                       String formattedDate =
//                           DateFormat('yyyy-MM-dd').format(pickedDate);
//                       setState(() {
//                         dateinput.text =
//                             formattedDate; //set output date to TextField value.
//                       });
//                     }
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please Select Transaction Date';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               GestureDetector(
//                 onTap: _onValidate,
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(
//                       horizontal: 16, vertical: 8),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF426da0),
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   padding: const EdgeInsets.symmetric(vertical: 15),
//                   width: double.infinity,
//                   alignment: Alignment.center,
//                   child: const Text(
//                     'Add Transaction',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontFamily: 'halter',
//                       fontSize: 14,
//                       package: 'flutter_credit_card',
//                     ),
//                   ),
//                 ),
//                 // ),
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   void _onValidate() {
//     if (formKey.currentState!.validate()) {
//       var data = TransactionModal(
//           category: category,
//         title: titleController.text,
//         description: descriptionController.text,
//         amount: int.parse(amountController.text),
//         date: dateinput.text,
//         type: types,
//       );
//
//       final box = Boxes.gettransactiondata();
//       box.add(data);
//       Navigator.pop(context);
//     } else {
//     }
//   }
//
// }
//
//
