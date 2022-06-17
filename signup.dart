import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:majorproject/register.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}
class _SignupScreenState extends State<SignupScreen> {
  final _formkey = GlobalKey<FormState>();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter email";
        }
        if (!RegExp("^[a-zA-z0-9+_.-]+@[a-zA-z0-9.-]+.[a-z]").hasMatch(value)) {
          return "Please enter valid email";
        }
        return null;
      },
      onSaved: (value) {
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter password";
        }
        if (value.length < 8) {
          return "Password must contain eight character";
        }
        return null;
      },
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please re-enter password";
        }
        if (passwordEditingController.text !=
            confirmPasswordEditingController.text) {
          return "Password do not match";
        }
        return null;
      },
      onSaved: (value) {
        confirmPasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );
    final registerButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery
            .of(context)
            .size
            .width,
        onPressed: () {
            if (_formkey.currentState!.validate()) {
              FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: emailEditingController.text,
                  password: passwordEditingController.text).then((value) {
                print("Created New Account");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()));
              return;
          }).onError((error, stackTrace) {
            print("Error ${error.toString()}");
          });
          }
          else {
          print("Unsuccessful");
          }
        },
        child: Text("SignUp", textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
        color: Colors.blueAccent,
      ),
    );

    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.blueAccent,
          title: Text('Fake Product Detection', textAlign: TextAlign.center,),),
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
                      SizedBox(height: 20),
                      emailField,
                      SizedBox(height: 15),
                      passwordField,
                      SizedBox(height: 15),
                      confirmPasswordField,
                      SizedBox(height: 15),
                      registerButton,
                    ],),
                ),
              ),),
          ),)
    );
  }
}
