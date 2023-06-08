import 'dart:math';
import 'package:cardsaver/models/notes_modal.dart';
import 'package:flutter/material.dart';
import 'package:cardsaver/constants/transaction_constant.dart';



class TransactionTile extends StatelessWidget {
  final TransactionModal transaction;

  const TransactionTile({Key? key, required this.transaction})
      : super(key: key);

  Color getBgColor() {
    return Color(Random().nextInt(0xffffffff));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: defaultSpacing),
      decoration: const BoxDecoration(
          color: background,
          boxShadow: [
            BoxShadow(
                blurRadius: 12,
                color: Colors.black12,
                offset: Offset.zero,
                spreadRadius: 3)
          ],
          borderRadius: BorderRadius.all(Radius.circular(defaultRadius))),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: getBgColor(),
              borderRadius:
                  const BorderRadius.all(Radius.circular(defaultRadius))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: transaction.category == "Fashion"
                ? const Icon(Icons.man, size: 30, color: Colors.white)
                : const Icon(Icons.wallet, size: 30, color: Colors.white),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: fontHeading, fontSize: fontSizeTitle),
        ),
        subtitle: Text(transaction.description),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(
            //   "-₹ ${transaction.amount}",
            //   style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w700,
            //       color: transaction.type == "Expense"
            //           ? Colors.red
            //           : primaryDark),
            // ),
            transaction.type == "Expense"
            ? Text("- ₹${transaction.amount}",style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w700,color: Colors.red))
            : Text("+ ₹${transaction.amount}",style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w700,color: primaryDark)),
            Text(
              transaction.date,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(color: fontSubHeading),
            )
          ],
        ),
      ),
    );
  }
}


