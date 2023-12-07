import 'package:flutter/material.dart';
import '../FirestoreObjects/FbPost.dart';

class PostGridView extends StatelessWidget {
  final List<FbPost> post;
  final int iPosicion;
  final Function(int indice)? onItemListaClickedFunction;
  final int numPostsFila;

  const PostGridView({
    super.key,
    required this.post,
    required this.iPosicion,
    required this.onItemListaClickedFunction,
    required this.numPostsFila
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: numPostsFila,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      padding: const EdgeInsets.all(8.0),
      itemCount: post.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            onItemListaClickedFunction!(index);
          },
          child: Container(
            color: Colors.blue,
            child: Stack(
              children: [
                if (post[index].urlImage.isNotEmpty) ...[
                  SizedBox(
                    width: double.infinity,
                    child: Image.network(
                      post[index].urlImage,
                      fit: BoxFit.cover, // Ajusta la imagen al tamaño del contenedor
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        post[index].titulo,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
                if (!post[index].urlImage.isNotEmpty)
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        post[index].titulo,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
