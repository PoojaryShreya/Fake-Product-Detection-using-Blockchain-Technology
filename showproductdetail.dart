import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'displaydetail.dart';
class ShowProduct extends StatefulWidget {
  @override
  _ShowProductState createState() => _ShowProductState();
}
class _ShowProductState extends State<ShowProduct> {
  final c = FirebaseAuth.instance.currentUser;
  List<String> docIDs = [];
  Future getDocId() async {
    await FirebaseFirestore.instance.collection('productdetail').get().then(
          (snapshot) => snapshot.docs.forEach((document) {
        print(document.reference);
        docIDs.add(document.reference.id);
      }),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueAccent,
          title: Text('Fake Product Detection', textAlign: TextAlign.center)),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: FutureBuilder(
                    future: getDocId(),
                    builder: (context,snapshot){
                      return ListView.builder(
                        itemCount: docIDs.length,
                        itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(title: DisplayDetail(documentId: docIDs[index]),
                              tileColor: Colors.lightBlueAccent,
                            ),
                          );
                        },
                      );
                    }
                ))
              ]
          )
      ),
    );
  }
}