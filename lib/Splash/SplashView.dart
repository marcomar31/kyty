import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kyty/FirestoreObjects/FbUsuario.dart';

import '../Singletone/DataHolder.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashViewState();
  }
}

class _SplashViewState extends State<SplashView> {

  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkSession();
  }

  void checkSession() async {
    await Future.delayed(const Duration(seconds: 4));
    if (FirebaseAuth.instance.currentUser != null) {
      String uidUsuario = FirebaseAuth.instance.currentUser!.uid;
      //DocumentSnapshot<Map<String, dynamic>> datos = await db.collection("Usuarios").doc(uidUsuario).get();

      DocumentReference<FbUsuario> reference = db
        .collection("Usuarios")
        .doc(uidUsuario)
        .withConverter(fromFirestore: FbUsuario.fromFirestore,
          toFirestore: (FbUsuario usuario, _) => usuario.toFirestore());

      DocumentSnapshot<FbUsuario> docSnap = await reference.get();

      //FbUsuario usuario = docSnap.data()!;
      Navigator.of(context).popAndPushNamed("/homeview");
        } else {
      Navigator.of(context).popAndPushNamed("/loginview");
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Column column = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child:
          Image.asset("resources/kyty_logo.png",
            width: DataHolder().platformAdmin.getScreenWidth() * 0.5,
            height: DataHolder().platformAdmin.getScreenHeight() * 0.5,
          ),
        ),
        const SizedBox(height: 30),
        const CircularProgressIndicator(),
      ],
    );

    return column;
  }

}