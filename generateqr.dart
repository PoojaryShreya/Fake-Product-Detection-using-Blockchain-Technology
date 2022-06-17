import 'package:flutter/material.dart';
import 'AES.dart';
import 'qrgenerator.dart';

class GenerateQR extends StatefulWidget {
  @override
  _GenerateQR createState() => _GenerateQR();
}

class _GenerateQR extends State<GenerateQR> {
  AESEncryption encryption = new AESEncryption();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Generate QR Code "),
      ),
      body: Container(
        child: Container(
          height: (MediaQuery.of(context).size.height),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: (MediaQuery.of(context).size.height) -
                      AppBar().preferredSize.height -
                      kToolbarHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //buildScanQRBtn(context),
                      SizedBox(
                        width: 5,
                      ),
                      buildGenerateQRBtn(context),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*Widget buildImage() => CircleAvatar(
  backgroundImage: AssetImage(
    "assets/images/QR.jpg",
  ),
  foregroundColor: Colors.transparent,
  backgroundColor: Colors.transparent,
  radius: 150,
);*/

Widget buildGenerateQRBtn(BuildContext context) => Container(
  width: ((MediaQuery.of(context).size.width) / 2) - 45,
  height: 50,
  child: ElevatedButton(
    child: Text(
      "Generate QR",
      style: TextStyle(fontSize: 17),
    ),
    onPressed: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => QRGenerator()));
    },
  ),
);