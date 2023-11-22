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
  String sVerificationCode="";
  bool blMostrarVerificacion = false;

  void enviarTelefono_clicked() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+34 666 66 66 66",
      verificationCompleted: verificacionCompletada,
      verificationFailed: verificacionFallida,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void enviarVerificacion_clicked() async {
    String smsCode = tecVerify.text;

    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: sVerificationCode, smsCode: smsCode);

    await FirebaseAuth.instance.signInWithCredential(credential);

    Navigator.of(context).popAndPushNamed("/homeview");
  }

  void verificacionCompletada(PhoneAuthCredential credencial) async {
    await FirebaseAuth.instance.signInWithCredential(credencial);
    Navigator.of(context).popAndPushNamed("/homeview");
  }

  void verificacionFallida(FirebaseAuthException error) {
    if (error.code == 'invalid-phone-number') {
      print('The provided phone number is not valid.');
    }
  }


  void codeSent(String verificationId, int? forceResendingToken) async {
    sVerificationCode = verificationId;
    setState(() {
      blMostrarVerificacion = true;
    });
  }

  void codeAutoRetrievalTimeout(String verificationId) {

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body:
      Column(children: [
        Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 100), child:
          ModedTextField(tec: tecPhone, hintText: "Número de teléfono"),
        ),
        TextButton(onPressed: enviarTelefono_clicked, child: Text("Enviar Teléfono")),
        if(blMostrarVerificacion)
          Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5), child:
            ModedTextField(tec: tecVerify, hintText: "Número verificador"),
          ),
        if(blMostrarVerificacion)
          TextButton(onPressed: enviarVerificacion_clicked, child: Text("Enviar"))
      ],)
    );
  }




  /*
  *
  * */
}