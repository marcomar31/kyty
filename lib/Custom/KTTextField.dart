import 'package:flutter/material.dart';

class KTTextField extends StatelessWidget {

  String hintText;
  TextEditingController tec;
  bool blIsPassword;
  double dPaddingH;
  double dPaddingV;

  // Constructor que acepta el hintText como parámetro
  KTTextField({Key? key, this.hintText="",
    required this.tec,
    this.blIsPassword = false,
    this.dPaddingH = 60,
    this.dPaddingV = 15,
  }) :super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Row row = Row(
      children: [
        Image.asset("resources/kyty_logo.png", width: 30, height: 30,),
        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: hintText,
          ),
        )
      ],
    );
    return row;
  }

}