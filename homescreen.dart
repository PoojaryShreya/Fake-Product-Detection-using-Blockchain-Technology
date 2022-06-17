import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:majorproject/enterproduct%20detail.dart';
import 'showproductdetail.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    final enterProductButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> EnterProduct()));
        },
        child: Text("Enter Product",textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
        color: Colors.blueAccent,
      ),
    );
    final showProductButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowProduct()));},
        child: Text("Show Product",textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
        color: Colors.blueAccent,
      ),
    );
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.blueAccent,
          title: Text('Fake Product Detection',textAlign: TextAlign.center,),),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 70,
                          child: Image.asset("assets/logo.png",
                            fit: BoxFit.contain,)),
                      SizedBox(height: 35),
                      enterProductButton,
                      SizedBox(height: 25),
                      showProductButton,
                    ],),),
              ),),
          ),)
    );
  }
}
