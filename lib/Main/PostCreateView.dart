import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kyty/Singletone/DataHolder.dart';

import '../FirestoreObjects/FbPost.dart';

class PostCreateView extends StatefulWidget{
  const PostCreateView({super.key});

  @override
  State<PostCreateView> createState() => _PostCreateViewState();
}

class _PostCreateViewState extends State<PostCreateView> {
  TextEditingController tecTitulo = TextEditingController();

  TextEditingController tecCuerpo = TextEditingController();

  TextEditingController tecImage = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  File _imagePreview = File("");

  void onGalleryClick() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imagePreview = File(image.path);
      });
    }
  }

  void onCameraClick() async {
    XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _imagePreview = File(image.path);
      });
    }
  }

  void subirPost() async {
    //--------INICIO DE SUBIR IMAGEN--------
    final storageRef = FirebaseStorage.instance.ref();

    String rutaEnNube = "posts/${FirebaseAuth.instance.currentUser!.uid}/imgs/${DateTime.now().year}_${DateTime.now().month}_${DateTime.now().day}_${DateTime.now().millisecondsSinceEpoch}";
    final rutaAFicheroEnNube = storageRef.child(rutaEnNube);

    final metadata = SettableMetadata(contentType: "image/jpeg");
    try {
      await rutaAFicheroEnNube.putFile(_imagePreview, metadata);

    } on FirebaseException {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al subir la imagen'),
          backgroundColor: Colors.red,
        ),
      );
    }
    //--------FIN DE SUBIR IMAGEN--------

    //--------INICIO DE SUBIR POST--------
    String urlImage = await rutaAFicheroEnNube.getDownloadURL();

    FbPost postNuevo = FbPost(
        titulo: tecTitulo.text,
        cuerpo: tecCuerpo.text,
        urlImage: urlImage);
    DataHolder().crearPostEnFB(postNuevo);
    //--------FIN DE SUBIR POST--------

    Navigator.of(context).popAndPushNamed("/homeview");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(title: const Text("SUBIR NUEVO POST")),
      body: Column(
        children: [
          Padding(padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
            child: TextField(
              controller: tecTitulo,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Título'
              )
            ),
          ),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
            child: TextField(
              controller: tecCuerpo,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Cuerpo'
              ),
            ),
          ),
          (_imagePreview.path.isEmpty)
              ? const Text("Ninguna imagen seleccionada")
              : Image.file(_imagePreview, width: 175, height: 175),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextButton(onPressed: onGalleryClick, child: const Text("Galería")),
              TextButton(onPressed: onCameraClick, child: const Text("Cámara")),
          ],),
          TextButton(onPressed: subirPost, child: const Text("PUBLICAR"))
        ],
      ),
    );
  }
}