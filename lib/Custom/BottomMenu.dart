import 'package:flutter/material.dart';


class BottomMenu extends StatelessWidget{

  Function(int indice)? onBotonesClicked;

  BottomMenu({super.key,required this.onBotonesClicked
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(onPressed: () => onBotonesClicked!(0), child: const Icon(Icons.list, color: Colors.white,)),
          TextButton(onPressed: () => onBotonesClicked!(1), child: const Icon(Icons.grid_view, color: Colors.white,)),
          TextButton(onPressed: () => onBotonesClicked!(2), child: const Icon(Icons.exit_to_app, color: Colors.white,))
        ]
    );
  }
}