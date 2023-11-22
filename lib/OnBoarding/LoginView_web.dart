import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kyty/FirestoreObjects/FbUsuario.dart';

import '../Custom/BottomMenu.dart';

class LoginView_web extends StatelessWidget {
  late BuildContext _context;
  FirebaseFirestore db = FirebaseFirestore.instance;

  TextEditingController tecUsername = TextEditingController();
  TextEditingController tecPassword = TextEditingController();

  SnackBar snackBar = const SnackBar(
    content: Text('Se produjo un error al intentar logearse.'),
  );

  LoginView_web({super.key});

  void onClickRegistrar() {
    Navigator.of(_context).popAndPushNamed('/registerview');
  }

  void onClickAceptarLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: tecUsername.text,
        password: tecPassword.text,
      );
      String uidUsuario = FirebaseAuth.instance.currentUser!.uid;

      DocumentReference<FbUsuario> ref = db.collection("Usuarios").doc(uidUsuario).withConverter(
        fromFirestore: FbUsuario.fromFirestore,
        toFirestore: (FbUsuario usuario, _) => usuario.toFirestore(),
      );

      DocumentSnapshot<FbUsuario> docSnap = await ref.get();
      if (docSnap.exists) {
        FbUsuario usuario = docSnap.data()!;
        Navigator.of(_context).popAndPushNamed("/homeview");
      } else {
        Navigator.of(_context).popAndPushNamed("/perfilview");
      }
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
    _context = context;

    Column columna = Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
          child: TextField(
            controller: tecUsername,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Username',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
          child: TextFormField(
            controller: tecPassword,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
            obscureText: true,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: TextButton(
                onPressed: onClickAceptarLogin,
                child: const Text("ACEPTAR"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: TextButton(
                onPressed: onClickRegistrar,
                child: const Text("REGISTRO"),
              ),
            ),
          ],
        ),
      ],
    );

    AppBar appBar = AppBar(
      title: const Text("LOGIN"),
      centerTitle: true,
      shadowColor: Colors.blue,
      backgroundColor: Colors.greenAccent.withOpacity(0.4),
      automaticallyImplyLeading: false,
    );

    return Scaffold(
      body: columna,
      appBar: appBar,
      bottomNavigationBar: BottomMenu(onBotonesClicked: onBottonMenuPressed),
    );
  }

  @override
  void onBottonMenuPressed(int indice) {
    if (indice == 0) exit(0);
    print("---------->>> LOGIN: $indice");
  }
}
