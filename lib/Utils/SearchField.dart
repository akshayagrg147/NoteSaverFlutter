//search field
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
      child: TextFormField(
        autofocus: false,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: "Search Passwords",
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          prefixIcon:
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ),
      ),
    );
  }
}