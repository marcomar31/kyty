import 'package:flutter/material.dart';

class PostListView extends StatelessWidget {

  final String sText;
  final double dFontSize;
  final int iPosicion;
  final Function(int indice) onItemListClickedFun;

  const PostListView({super.key,
    required this.sText,
    required this.dFontSize,
    required this.iPosicion,
    required this.onItemListClickedFun});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      child: Container(
          child: Row(
            children: [
              Image.asset("resources/kyty_logo.png",width: 70,
                  height: 70),
              Text(sText,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: dFontSize),
              ),
              Spacer(),
              TextButton(onPressed: null, child: Text("+",style: TextStyle(fontSize: dFontSize)))
            ],
          )

      ),
      onTap: () {
        onItemListClickedFun(iPosicion);
        //print("tapped on container " + iPosicion.toString());
      },
    );
  }

}