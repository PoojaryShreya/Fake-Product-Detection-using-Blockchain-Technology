import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GeneratedQR extends StatefulWidget {
  final myQR;
  const GeneratedQR(this.myQR);

  @override
  _GeneratedQRState createState() => _GeneratedQRState();
}

class _GeneratedQRState extends State<GeneratedQR> {
  CollectionReference qrdetail = FirebaseFirestore.instance.collection("productdetail");
  @override
  Widget build(BuildContext context) {
    final registerButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          final product = Product(QRCode: widget.myQR);
          },
        child: Text("Upload",textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
        color: Colors.blueAccent,
    ),
      );
    return Scaffold(
      appBar: AppBar(
        title: Text("Generated QR "),

      ),
      body: Center(
        child: QrImage(
          data: widget.myQR,
          version: QrVersions.auto,
          size: 250.0,
          gapless: false,
        ),
      ),
    );
  }
}
class Product{
  final Widget QRCode;
  Product({required this.QRCode});
  Map<String,dynamic> toJson() => {
     'QRCode': QRCode };
}