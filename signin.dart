import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:majorproject/homescreen.dart';


class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}
class _SigninScreenState extends State<SigninScreen> {
  /*static Future<User?> loginUsingEmailandPassword({required String email,required String password,required BuildContext context} ) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
  } on FirebaseAuthException catch (e){
      if(e.code == 'user-not-found'){
        print("No user found for that email");
  }
  }return user;
}*/
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value){
        if(value!.isEmpty){
          return "Please enter email";
        }
        if(!RegExp("^[a-zA-z0-9+_.-]+@[a-zA-z0-9.-]+.[a-z]").hasMatch(value))
        {
          return "Please enter valid email";
        }
        return null;
      },
      onSaved: (value){
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )
      ),
    );
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value){
        if(value!.isEmpty){
          return "Please enter password";
        }
        if(value.length <8) {
          return "Password must contain eight character";
        }
        return null;
      },
      onSaved: (value){
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
      prefixIcon: Icon(Icons.vpn_key),
      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      hintText: "Password",
      border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      )
      ),
    );
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: ()  {
         /*User? user = await loginUsingEmailandPassword(email: emailController.text, password: passwordController.text, context: context);
          print(user);
          if(user != null){*/
          FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text,
              password: passwordController.text).then((value) {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
          }).onError((error, stackTrace) {
            print("Error ${error.toString()}");
          });

              //return;
          //}
          /*else{
            print("No User Exist");
          }*/
        },
        child: Text("Login",textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
        color: Colors.blueAccent,
      ),
    );
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: (){
            Navigator.of(context).pop();
          },),
          title: Text('Company Login',textAlign: TextAlign.center,),),
    body:
      Center(
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

      SizedBox(height: 200,
      child: Image.asset("assets/logo.png",
    fit: BoxFit.contain,)),
      SizedBox(height: 45),
      emailField,
      SizedBox(height: 25),
    passwordField,
    SizedBox(height: 35),
    loginButton,
    SizedBox(height: 15),
     /* Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Text("Don't have  an account? "),
          GestureDetector(onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> SignupScreen()));
          },
            child: Text("SignUp",
              style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold,fontSize: 15),
            ),)
        ],),*/
        ],),
    ),),
    ),
    ),),
    );
  }
}