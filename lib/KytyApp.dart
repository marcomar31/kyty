import 'package:flutter/material.dart';
import 'package:kyty/Main/HomeView.dart';
import 'package:kyty/OnBoarding/LoginView.dart';
import 'package:kyty/OnBoarding/PerfilView.dart';
import 'package:kyty/Splash/SplashView.dart';

import 'OnBoarding/RegisterView.dart';

class KytyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    MaterialApp materialApp = MaterialApp(title: "KytY Miau!",
      initialRoute: '/homeview',
      routes: {
        '/loginview': (context) => LoginView(),
        '/registerview': (context) => RegisterView(),
        '/homeview': (context) => HomeView(),
        '/splashview': (context) => SplashView(),
        '/perfilview': (content) => PerfilView(),
      },
    );

    return materialApp;
  }

}