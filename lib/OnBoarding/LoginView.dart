import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {

  late BuildContext _context;

  TextEditingController tecUsername = TextEditingController();
  TextEditingController tecPassword = TextEditingController();

  SnackBar snackBar = SnackBar(
      content: Text('Se produjo un error al intentar logearse.')
  );

  void onClickRegistrar() {
    Navigator.of(_context).popAndPushNamed('/registerview');
  }

  void onClickAceptarLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: tecUsername.text,
          password: tecPassword.text,
      );
      Navigator.of(_context).popAndPushNamed('/homeview');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(_context).showSnackBar(snackBar);
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _context = context;
    Column columna = new Column(children: [
      //Text("LOGIN", style: TextStyle(fontSize: 25),),
      Padding(padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
        child: TextField(
          controller: tecUsername,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input User',
          ),
        ),
      ),
      Padding(padding: EdgeInsets.symmetric(horizontal: 50, vertical: 0),
        child: TextFormField(
          controller: tecPassword,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input Password',
          ),
          obscureText: true,
        ),
      ),

      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20), child:
          TextButton(onPressed: onClickAceptarLogin, child: Text("ACEPTAR")),
        ),

        Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20), child:
          TextButton(onPressed: onClickRegistrar, child: Text("REGISTRO")),
        ),
      ],),
    ]);

    AppBar appBar = AppBar(
      title: const Text("LOGIN"),
      centerTitle: true,
      shadowColor: Colors.blue,
      backgroundColor: Colors.greenAccent.withOpacity(0.4),
      automaticallyImplyLeading: false,
    );

    Scaffold scaffold = Scaffold(body: columna,
      backgroundColor: Colors.greenAccent,
      appBar: appBar,);

    return scaffold;
  }

}