import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kyty/Main/HomeView.dart';
import 'package:kyty/Main/PostCreateView.dart';
import 'package:kyty/OnBoarding/LoginView.dart';
import 'package:kyty/OnBoarding/PerfilView.dart';
import 'package:kyty/OnBoarding/PhoneLoginView.dart';
import 'package:kyty/Splash/SplashView.dart';

import 'Main/PostView.dart';
import 'OnBoarding/RegisterView.dart';

class KytyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    MaterialApp materialApp;

    if (kIsWeb) {

      return MaterialApp(title: "KytY Miau!",
        initialRoute: '/loginview',
        routes: {
          '/loginview': (context) => LoginView(),
          '/registerview': (context) => RegisterView(),
          '/homeview': (context) => HomeView(),
          '/splashview': (context) => SplashView(),
          '/perfilview': (content) => PerfilView(),
          '/postview':(context) => PostView(),
          '/postcreateview': (context) => PostCreateView(),
        },
      );
    } else {
      return MaterialApp(title: "KytY Miau!",
        initialRoute: '/loginview',
        routes: {
          '/loginview': (context) => PhoneLoginView(),
          '/registerview': (context) => RegisterView(),
          '/homeview': (context) => HomeView(),
          '/splashview': (context) => SplashView(),
          '/perfilview': (content) => PerfilView(),
          '/postview':(context) => PostView(),
          '/postcreateview': (context) => PostCreateView(),
        },
      );
    }
  }

}