
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kyty/Singletone/DataHolder.dart';

import '../FirestoreObjects/FbPost.dart';

class PostCreateView extends StatelessWidget{
  TextEditingController tecTitulo = TextEditingController();
  TextEditingController tecCuerpo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(title: Text("SUBIR NUEVO POST")),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
            child: Flexible(child: TextField(
              controller: tecTitulo,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Título'
              ),
            ),
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
            child: Flexible(child: TextField(
              controller: tecCuerpo,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Cuerpo'
              ),
            ),
            ),
          ),
          TextButton(onPressed: () {
            FbPost postNuevo=new FbPost(
                titulo: tecTitulo.text,
                cuerpo: tecCuerpo.text,
            );

            DataHolder().crearPostEnFB(postNuevo);

            Navigator.of(context).popAndPushNamed("/homeview");
          },
              child: Text("PUBLICAR"))
        ],
      ),
    );
  }
}