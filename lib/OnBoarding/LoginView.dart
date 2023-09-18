import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Column columna = new Column(children: [
      Text("LOGIN"),
      Text("Input user"),
      Text("Input password"),
      Row(children: [
        TextButton(onPressed: (){}, child: Text("ACEPTAR")),
        TextButton(onPressed: (){}, child: Text("CANCELAR"))
      ],),
    ]); //Column
    return columna;
  }

}