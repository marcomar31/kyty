import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kyty/FirestoreObjects/FbUsuario.dart';

class PerfilView extends StatelessWidget {

  late BuildContext _context;
  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController tecNombre = TextEditingController();
  TextEditingController tecEdad = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(body:
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        Text("Personaliza tu perfil", style: TextStyle(fontSize: 33)),
        Padding(padding: EdgeInsets.symmetric(vertical: 16),
          child: Flexible(
            child: SizedBox(width: 400,
              child: TextField(
                controller: tecNombre,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre'
                ),
              ),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 10
        ),
          child: Flexible(
            child: SizedBox(width: 400,
              child: TextFormField(
                controller: tecEdad,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Edad'
                ),
              ),
            ),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20), child:
          TextButton(onPressed: onClickAceptar, child: Text("ACEPTAR")),
          ),

          Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20), child:
          TextButton(onPressed: onClickCancelar, child: Text("CANCELAR")),
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

  void onClickAceptar() {
    int edadUsuario = 0;
    bool excepcion = false;
    try {
      edadUsuario = int.parse(tecEdad.text);
    } on Exception {
      ScaffoldMessenger.of(_context).showSnackBar(SnackBar(content: Text("Por favor, introduzca un número")));
      excepcion = true;
    }
    if (!excepcion) {
      if (edadUsuario <= 0) {
        ScaffoldMessenger.of(_context).showSnackBar(SnackBar(content: Text("Por favor, introduzca una edad positiva")));
      } else {
        FbUsuario usuario = new FbUsuario(nombre: tecNombre.text, edad: edadUsuario, altura: 0);
        bool excepcion = false;
        try {
          //UID del usuario que está logeado
          String uidUsuario = FirebaseAuth.instance.currentUser!.uid;
          db.collection('Usuarios').doc(uidUsuario).set(usuario.toFirestore());

          //Crear documento con ID AUTO
          //db.collection("Usuarios").add(usuario);

          //Crear documento con ID NUESTRO (o proporcionado por nosotros)
          //db.collection("Usuarios").doc("1").set(usuario);
        } on Exception {
          ScaffoldMessenger.of(_context).showSnackBar(SnackBar(content: Text("Se ha producido un error al completar el perfil del usuario")));
          excepcion = true;
        }
        if (!excepcion) {
          Navigator.of(_context).popAndPushNamed("/homeview");
        }
      }
    }
  }
}