import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
import '../../constants/notes_constant.dart';

class CustomTextField extends StatelessWidget {
  const

  CustomTextField(
      {super.key,
      required this.hint,
      this.maxLines = 1,
      this.onSaved,
      this.onChanged,
      required this.initialValue,
      });

  final hint;
  final int maxLines;
  final initialValue;


  final void Function(String?)? onSaved;

  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    // if (intialValue == "A"){
    //   intialValue = null;
    // }
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      onSaved: onSaved,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Field is required ';
        } else {
          return null;
        }
      },
      cursorColor: kPrimaryColor,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black),
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(kPrimaryColor),
      ),
    );
  }

  OutlineInputBorder buildBorder([color]) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: color ?? Colors.black)
    );
  }
}
