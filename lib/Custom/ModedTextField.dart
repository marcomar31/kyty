import 'package:flutter/material.dart';

class ModedTextField extends StatelessWidget {

  String hintText;
  TextEditingController tec;
  bool blIsPassword;
  double dPaddingH;
  double dPaddingV;

  // Constructor que acepta el hintText como parámetro
  ModedTextField({super.key, this.hintText="",
    required this.tec,
    this.blIsPassword = false,
    this.dPaddingH = 60,
    this.dPaddingV = 15,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Row row = Row(
      children: [
        Image.asset("resources/kyty_logo.png", width: 30, height: 30,),
        Flexible(
          child: TextFormField(
            controller: tec,
            obscureText: blIsPassword,
            enableSuggestions: !blIsPassword,
            autocorrect: !blIsPassword,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: hintText)
          ),
        ),
      ],
    );
    return row;
  }

}