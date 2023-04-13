//search field
import 'package:cardsaver/notesave/notes_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SearchField extends StatelessWidget {
  const SearchField( {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
      child: TextFormField(
        autofocus: false,
        style: const TextStyle(color: Colors.black),
        // onChanged: onSearchTextChanged,
        decoration: InputDecoration(
          contentPadding:
          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
          hintText: "Search Passwords",
          filled: true,
          border: OutlineInputBorder(
            // borderSide: BorderSide.none,
            borderSide: const BorderSide(),
            borderRadius: const BorderRadius.all(Radius.circular(25)),
          ),
          prefixIcon:
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),


        ),
      ),
    );
  }

}