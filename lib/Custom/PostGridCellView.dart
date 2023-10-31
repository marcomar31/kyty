import 'package:flutter/material.dart';

import '../FirestoreObjects/FbPost.dart';

class PostGridCellView extends StatelessWidget {

  final List<FbPost> post;
  final int iPosicion;
  final Function (int indice)? onItemListaClickedFunction;

  const PostGridCellView({
    super.key,
    required this.post,
    required this.iPosicion,
    required this.onItemListaClickedFunction
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      padding: EdgeInsets.all(8.0),
      itemCount: post.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(child:
          Container(child:
            Center(child:
              Text(post[index].titulo),
            ),
            color: Colors.blue,),
          onTap: () {
            onItemListaClickedFunction!(index);
          },
        );
      },
    );
  }
}