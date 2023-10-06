import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {

  late BuildContext _context;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();

  SnackBar snackBar = SnackBar(
      content: Text('Las contraseñas no coinciden.')
  );

  void onCLickCancelar() {
    Navigator.of(_context).popAndPushNamed('/loginview');
  }

  void onClickAceptarRegister() async {
    if (passwordController.text == repasswordController.text) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: usernameController.text,
          password: passwordController.text,
        );
        Navigator.of(_context).popAndPushNamed('/perfilview');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    } else {
      ScaffoldMessenger.of(_context).showSnackBar(snackBar);
    }
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _context = context;
    Column columna = new Column(children: [
      //Text("LOGIN", style: TextStyle(fontSize: 25),),
      Padding(padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
        child: Flexible(child: TextField(
          controller: usernameController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Username'
          ),
        ),
        ),
      ),
      Padding(padding: EdgeInsets.symmetric(horizontal: 50, vertical: 0),
        child: Flexible(child: TextFormField(
          controller: passwordController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Password'
          ),
          obscureText: true,
        ),
        ),
      ),
      Padding(padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
        child: Flexible(child: TextFormField(
          controller: repasswordController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Repassword'
          ),
          obscureText: true,
        ),
        ),
      ),

      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20), child:
        TextButton(onPressed: onClickAceptarRegister, child: Text("ACEPTAR")),
        ),

        Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20), child:
        TextButton(onPressed: onCLickCancelar, child: Text("CANCELAR")),
        ),
      ],),
    ]);

    AppBar appBar = AppBar(
      title: const Text("REGISTER"),
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