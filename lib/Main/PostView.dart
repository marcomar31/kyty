import 'package:flutter/material.dart';
import 'package:kyty/Singletone/DataHolder.dart';
import '../FirestoreObjects/FbPost.dart';

class PostView extends StatefulWidget {
  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  FbPost selectedPost = FbPost(titulo: "Cargando...", cuerpo: "Cargando...", urlImage: "https://instastudio.mx/wp-content/uploads/2021/10/Blanco_Mesa-de-trabajo-1.png"); //Valor predeterminado

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
      body: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Column(children: [
                  Text(selectedPost.titulo),
                  Text(selectedPost.cuerpo),
                  if (selectedPost.urlImage != "")
                    Image.network(selectedPost.urlImage, width: 300, height: 300,),
                  if (selectedPost.urlImage == "")
                    Image.asset(
                      "resources/kyty_logo.png",
                      width: 300,
                      height: 300,
                    ),
                  TextButton(onPressed: null, child: Text("Like")),
                ],),
        ],
      )
          //:  CircularProgressIndicator(),
    );
  }
}
