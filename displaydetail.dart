import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class DisplayDetail extends StatelessWidget {
  final String documentId;
  DisplayDetail({required this.documentId});
  @override
  Widget build(BuildContextcontext) {
    CollectionReference products = FirebaseFirestore.instance.collection('details');
    return FutureBuilder<DocumentSnapshot>(
      future: products.doc(documentId).get(),
      builder: ((context, snapshot) {
      if(snapshot.connectionState == ConnectionState.done){
        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;
        return Text('product_name: ${data['product_name']}');
      }
      return Text('loading...');
    }),
    );
  }
}