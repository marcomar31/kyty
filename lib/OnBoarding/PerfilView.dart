import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kyty/FirestoreObjects/FbUsuario.dart';

class PerfilView extends StatelessWidget {

  late BuildContext _context;
  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController tecNombre = TextEditingController();
  TextEditingController tecEdad = TextEditingController();

  PerfilView({super.key});

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(body:
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        const Text("Personaliza tu perfil", style: TextStyle(fontSize: 33)),
        Padding(padding: const EdgeInsets.symmetric(vertical: 16),
          child: Flexible(
            child: SizedBox(width: 400,
              child: TextField(
                controller: tecNombre,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre'
                ),
              ),
            ),
          ),
        ),
        Padding(padding: const EdgeInsets.symmetric(vertical: 10
        ),
          child: Flexible(
            child: SizedBox(width: 400,
              child: TextFormField(
                controller: tecEdad,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Edad'
                ),
              ),
            ),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20), child:
          TextButton(onPressed: onClickAceptar, child: const Text("ACEPTAR")),
          ),

          Padding(padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20), child:
          TextButton(onPressed: onClickCancelar, child: const Text("CANCELAR")),
          ),
        ],),
      ]),
      appBar: AppBar(
        title: const Text("PERFIL"),
        centerTitle: true,
        shadowColor: Colors.blue,
        backgroundColor: Colors.greenAccent.withOpacity(0.4)),
    );
  }


  void onClickCancelar() {
    Navigator.of(_context).popAndPushNamed("/loginview");
  }

  void onClickAceptar() async{

    FbUsuario usuario = FbUsuario(nombre: tecNombre.text,
        edad: int.parse(tecEdad.text), altura: 0,colorPelo: "",
        geoloc: const GeoPoint(0,0));


    //Crear documento con ID NUESTRO (o proporsionado por nosotros)
    String uidUsuario= FirebaseAuth.instance.currentUser!.uid;
    await db.collection("Usuarios").doc(uidUsuario).set(usuario.toFirestore());

    Navigator.of(_context).popAndPushNamed("/homeview");
  }
}