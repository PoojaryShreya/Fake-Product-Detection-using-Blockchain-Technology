import "package:flutter/material.dart";
import 'package:majorproject/signin.dart';
import 'authenticatecompany.dart';
class SignupinState extends StatefulWidget {
  @override
  _SignupinScreenState createState() => _SignupinScreenState();
}
class SignupinScreen extends StatefulWidget {
  @override
  _SignupinScreenState createState() => _SignupinScreenState();
}
class _SignupinScreenState extends State<SignupinScreen> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    final registerButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AuthenticateState()));
          },
        child: Text("SignUp",textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
        color: Colors.blueAccent,
      ),
    );
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> SigninScreen()));},
        child: Text("SignIN",textAlign: TextAlign.center,
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
              color: Colors.lightBlueAccent,
              child: Padding(padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 150,
                          child: Image.asset("assets/logo.png",
                            fit: BoxFit.contain,)),

                      SizedBox(height: 35),
                      registerButton,
                      SizedBox(height: 25),
                      loginButton,
                    ],),
                ),
              ),),
          ),)
    );
  }
}