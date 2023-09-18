import 'package:flutter/material.dart';
import 'package:kyty/OnBoarding/LoginView.dart';

class KytyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    MaterialApp materialApp = MaterialApp(title: "KytY Miau!", home: LoginView());

    return materialApp;
  }

}