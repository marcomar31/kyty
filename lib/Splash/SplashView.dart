import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kyty/FirestoreObjects/FbUsuario.dart';

import '../Singletone/DataHolder.dart';

class SplashView extends StatefulWidget {
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
    await Future.delayed(Duration(seconds: 4));
    if (FirebaseAuth.instance.currentUser != null) {
      String uidUsuario = FirebaseAuth.instance.currentUser!.uid;
      //DocumentSnapshot<Map<String, dynamic>> datos = await db.collection("Usuarios").doc(uidUsuario).get();

      DocumentReference<FbUsuario> reference = db
        .collection("Usuarios")
        .doc(uidUsuario)
        .withConverter(fromFirestore: FbUsuario.fromFirestore,
          toFirestore: (FbUsuario usuario, _) => usuario.toFirestore());

      DocumentSnapshot<FbUsuario> docSnap = await reference.get();

      FbUsuario usuario = docSnap.data()!;
      if (usuario!=null) {
        print("El manin este se llama: "+usuario.nombre);
        print("El manin tiene "+usuario.edad.toString()+" años");
        print("El manin mide "+usuario.altura.toString());
        Navigator.of(context).popAndPushNamed("/homeview");
      } else {
        Navigator.of(context).popAndPushNamed("/perfilview");
      }
    } else {
      Navigator.of(context).popAndPushNamed("/loginview");
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Column column = Column(
      children: [
        Positioned(
            left: DataHolder().platformAdmin.getScreenWidth()*0.1,
            top: DataHolder().platformAdmin.getScreenHeight()*0.1,
            width: DataHolder().platformAdmin.getScreenWidth()*0.8,
            height: DataHolder().platformAdmin.getScreenHeight()*0.8,
            child: Image.asset("resources/kyty_logo.png",)
        ),
        Padding(padding: EdgeInsets.all(30)),

        Positioned(
            left: DataHolder().platformAdmin.getScreenWidth()*0.1,
            top: DataHolder().platformAdmin.getScreenHeight()*0.1,
            width: DataHolder().platformAdmin.getScreenWidth()*0.8,
            height: DataHolder().platformAdmin.getScreenHeight()*0.8,
            child: CircularProgressIndicator()
        ),
      ],
    );

    return column;
  }

}