import 'package:flutter/material.dart';
import 'package:kyty/Singletone/DataHolder.dart';
import '../FirestoreObjects/FbPost.dart';

class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  FbPost selectedPost = FbPost(titulo: "Cargando...", cuerpo: "Cargando...", urlImage: ""); //Valor predeterminado

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
      appBar: AppBar(title: Text(DataHolder().selectedPost!.titulo)),
      body: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Column(children: [
                  Padding(padding: const EdgeInsets.only(top: 20), child:
                  (selectedPost.urlImage == "")
                    ? Container(width: 300, height: 300, color: Colors.grey[300] , child:
                          const Align(
                            alignment: Alignment.center,
                            child: Text("Post sin imagen"),
                          ),
                      )
                    : Image.network(selectedPost.urlImage, width: 300, height: 300,),
                  ),
                  const TextButton(onPressed: null, child: Text("Like")),
                  Text(selectedPost.cuerpo),
          ],),
        ],
      )
          //:  CircularProgressIndicator(),
    );
  }
}
