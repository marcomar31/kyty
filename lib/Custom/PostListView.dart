import 'package:flutter/material.dart';
import 'package:kyty/FirestoreObjects/FbPost.dart';

class PostListView extends StatelessWidget {

  final FbPost post;
  final double dFontSize;
  final int iPosicion;
  final Function(int indice) onItemListClickedFun;

  const PostListView({super.key,
    required this.post,
    required this.dFontSize,
    required this.iPosicion,
    required this.onItemListClickedFun});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      child: SizedBox(
        height: 70, // Ajusta la altura según tus necesidades
        child: Row(
          children: [
            (post.urlImage == "")
                ? Image.asset("resources/kyty_logo.png", width: 70, height: 70)
                : Image.network(
                    post.urlImage,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
            const SizedBox(width: 15,),
            Text(
              post.titulo,
              style: TextStyle(
                color: Colors.white,
                fontSize: dFontSize,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: null,
              child: Text("+", style: TextStyle(fontSize: dFontSize)),
            ),
          ],
        ),
      ),
      onTap: () {
        onItemListClickedFun(iPosicion);
        //print("tapped on container " + iPosicion.toString());
      },
    );

  }

}