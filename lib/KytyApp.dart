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
import 'Singletone/DataHolder.dart';

class KytyApp extends StatelessWidget {
  const KytyApp({super.key});


  @override
  Widget build(BuildContext context) {
    DataHolder().initPlatformAdmin(context);

    // TODO: implement build
    if (kIsWeb) {
      return MaterialApp(title: "KytY Miau Web!",
        routes: {
          '/loginview': (context) => LoginView_web(),
          '/registerview': (context) => RegisterView(),
          '/homeview': (context) => const HomeView_web(),
          '/splashview': (context) => const SplashView(),
          '/perfilview': (content) => PerfilView(),
          '/postview':(context) => const PostView(),
          '/postcreateview': (context) => const PostCreateView(),
        },
        initialRoute: '/splashview',
      );
    } else {
      return MaterialApp(title: "KytY Miau Mobile!",
        routes: {
          '/loginview': (context) => const LoginView_mobile(),
          '/registerview': (context) => RegisterView(),
          '/homeview': (context) => const HomeView_web(),
          '/splashview': (context) => const SplashView(),
          '/perfilview': (content) => PerfilView(),
          '/postview':(context) => const PostView(),
          '/postcreateview': (context) => const PostCreateView(),
        },
        initialRoute: '/splashview',
      );
    }
  }

}