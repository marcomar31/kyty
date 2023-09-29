import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashViewState();
  }
}

class _SplashViewState extends State<SplashView> {
  late BuildContext _context;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkSession();
  }

  void checkSession() async {
    await Future.delayed(Duration(seconds: 4));
    if (FirebaseAuth.instance.currentUser != null) {
      Navigator.of(_context).popAndPushNamed("/homeview");
    } else {
      Navigator.of(_context).popAndPushNamed("/loginview");
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _context = context;

    Column column = Column(
      children: [
        Image.asset('resources/kyty_logo.png', width: 200, height: 200,),
        Padding(padding: EdgeInsets.all(30)),
        CircularProgressIndicator()
      ],
    );

    return column;
  }

}