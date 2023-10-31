import 'package:flutter/material.dart';
import 'package:kyty/Singletone/DataHolder.dart';
import '../FirestoreObjects/FbPost.dart';

class PostView extends StatefulWidget {
  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  FbPost selectedPost = FbPost(titulo: "Cargando...", cuerpo: "Cargando..."); //Valor predeterminado

  @override
  void initState() {
    super.initState();
    cargarPostGuardadoEnCache();
  }

  void cargarPostGuardadoEnCache() async {
    var temp1 = await DataHolder().loadCachedFbPost();
    setState(() {
      selectedPost = temp1!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: selectedPost != null
          ? Text(DataHolder().selectedPost!.titulo)
          : Text("CARGANDO...")),
      body: //selectedPost != null
          /*?*/ Column(children: [
              Text(selectedPost.titulo),
              Text(selectedPost.cuerpo),
              Image.asset(
                "resources/kyty_logo.png",
                width: 70,
                height: 70,
              ),
              TextButton(onPressed: null, child: Text("Like")),
            ],)
          //:  CircularProgressIndicator(),
    );
  }
}
