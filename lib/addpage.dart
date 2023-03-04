import 'package:flutter/material.dart';
import 'package:cardsaver/credit_card_page.dart';
import 'package:cardsaver/homepage.dart';
void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('ADD'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  CreditCardPage()),
            );
          },
        ),
      ),
    );
  }
}
