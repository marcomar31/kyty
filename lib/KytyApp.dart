import 'package:flutter/material.dart';
import 'package:kyty/OnBoarding/LoginView.dart';

import 'OnBoarding/RegisterView.dart';

class KytyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    MaterialApp materialApp = MaterialApp(title: "KytY Miau!",
      initialRoute: '/loginview',
      routes: {
        '/loginview': (context) => LoginView(),
        '/registerview': (context) => RegisterView(),
      },
    );

    return materialApp;
  }

}