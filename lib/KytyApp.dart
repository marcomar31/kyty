import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kyty/Main/HomeView_web.dart';
import 'package:kyty/Main/PostCreateView.dart';
import 'package:kyty/OnBoarding/LoginView_web.dart';
import 'package:kyty/OnBoarding/PerfilView.dart';
import 'package:kyty/OnBoarding/LoginView_mobile.dart';
import 'package:kyty/Splash/SplashView.dart';

import 'Main/PostView.dart';
import 'OnBoarding/RegisterView.dart';

class KytyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (kIsWeb) {

      return MaterialApp(title: "KytY Miau!",
        routes: {
          '/loginview': (context) => LoginView_web(),
          '/registerview': (context) => RegisterView(),
          '/homeview': (context) => HomeView_web(),
          '/splashview': (context) => SplashView(),
          '/perfilview': (content) => PerfilView(),
          '/postview':(context) => PostView(),
          '/postcreateview': (context) => PostCreateView(),
        },
        initialRoute: '/loginview',
      );
    } else {
      return MaterialApp(title: "KytY Miau!",
        routes: {
          '/loginview': (context) => LoginView_mobile(),
          '/registerview': (context) => RegisterView(),
          '/homeview': (context) => HomeView_web(),
          '/splashview': (context) => SplashView(),
          '/perfilview': (content) => PerfilView(),
          '/postview':(context) => PostView(),
          '/postcreateview': (context) => PostCreateView(),
        },
        initialRoute: '/loginview',
      );
    }
  }

}