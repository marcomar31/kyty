import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kyty/Singletone/DataHolder.dart';

import '../FirestoreObjects/FbPost.dart';

class PostCreateView extends StatefulWidget{
  @override
  State<PostCreateView> createState() => _PostCreateViewState();
}

class _PostCreateViewState extends State<PostCreateView> {
  TextEditingController tecTitulo = TextEditingController();

  TextEditingController tecCuerpo = TextEditingController();

  TextEditingController tecImage = TextEditingController();

  ImagePicker _picker = ImagePicker();

  File _imagePreview = File("");

  void onGallery_clicked() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imagePreview = File(image.path);
      });
    }
  }

  void onCamera_clicked() async {
    XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _imagePreview = File(image.path);
      });
    }
  }

  void subirPost() async {
    //-----------------------INICIO DE SUBIR IMAGEN--------
    final storageRef = FirebaseStorage.instance.ref();

    String rutaEnNube =
        "posts/"+FirebaseAuth.instance.currentUser!.uid+"/imgs/"+
            DateTime.now().millisecondsSinceEpoch.toString();
    final rutaAFicheroEnNube = storageRef.child(rutaEnNube);
    // Create the file metadata
    final metadata = SettableMetadata(contentType: "image/jpeg");
    try {
      await rutaAFicheroEnNube.putFile(_imagePreview,metadata);

    } on FirebaseException catch (e) {
      print("ERROR AL SUBIR IMAGEN: "+e.toString());
    }

    print("SE HA SUBIDO LA IMAGEN");

    String urlImage = await rutaAFicheroEnNube.getDownloadURL();

    print("URL DE DESCARGA: " + urlImage);

    //-----------------------FIN DE SUBIR IMAGEN--------

    //-----------------------INICIO DE SUBIR POST--------

    FbPost postNuevo = new FbPost(
        titulo: tecTitulo.text,
        cuerpo: tecCuerpo.text,
        urlImage: urlImage);
    DataHolder().crearPostEnFB(postNuevo);
    Navigator.of(context).popAndPushNamed("/homeview");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(title: Text("SUBIR NUEVO POST")),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
            child: TextField(
              controller: tecTitulo,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Título'
              )
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
            child: TextField(
              controller: tecCuerpo,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Cuerpo'
              ),
            ),
          ),
          Image.file(_imagePreview,width: 175,height: 175,),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextButton(onPressed: onGallery_clicked, child: Text("Galería")),
              TextButton(onPressed: onCamera_clicked, child: Text("Cámara")),
          ],),
          TextButton(onPressed: subirPost, child: Text("PUBLICAR"))
        ],
      ),
    );
  }
}