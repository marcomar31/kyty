import 'package:flutter/material.dart';

class PostCellView extends StatelessWidget {

  final String sText;
  final int iColorCode;
  final double dFontSize;

  const PostCellView ({super.key,
    required this.sText,
    required this.iColorCode,
    required this.dFontSize
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(sText,
      style: TextStyle(
          color: Colors.blue[iColorCode],
          fontSize: dFontSize),
    );
  }

}