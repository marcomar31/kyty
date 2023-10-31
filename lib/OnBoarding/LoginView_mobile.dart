import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Custom/ModedTextField.dart';

class LoginView_mobile extends StatefulWidget {
  @override
  State<LoginView_mobile> createState() => _LoginView_mobileState();
}

class _LoginView_mobileState extends State<LoginView_mobile> {
  TextEditingController tecPhone = TextEditingController();
  TextEditingController tecVerify = TextEditingController();

  void enviarTelefono_clicked() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+44 7123 123 456',
      verificationCompleted: verificacionCompletada,
      verificationFailed: verificacionFallida,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void enviarVerificacion_clicked() {

  }

  void verificacionCompletada(PhoneAuthCredential phoneAuthCredential) {

  }

  void verificacionFallida(FirebaseAuthException error) {

  }


  void codeSent(String verificationId, int? forceResendingToken) {

  }

  void codeAutoRetrievalTimeout(String verificationId) {

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body:
      Column(children: [
        ModedTextField(tec: tecPhone, hintText: "Número de teléfono"),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20), child:
          TextButton(onPressed: enviarTelefono_clicked, child: Text("Enviar Teléfono")),
          ),
        ],),
        ModedTextField(tec: tecVerify, hintText: "Número verificador"),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20), child:
          TextButton(onPressed: enviarVerificacion_clicked, child: Text("Enviar Verificación")),
          ),
        ],),
      ]),
    );
  }
}