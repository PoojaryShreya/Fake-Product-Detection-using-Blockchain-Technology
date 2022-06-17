import 'package:flutter/material.dart';
import 'signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
  //FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference details = FirebaseFirestore.instance.collection("details");
  _RegisterScreenState registerScreen = _RegisterScreenState();
  final _formkey = GlobalKey<FormState>();
  final companyNameEditingController = new TextEditingController();
  final founderNameEditingController = new TextEditingController();
  final phoneNumberEditingController = new TextEditingController();
  final locationEditingController = new TextEditingController();
  final CINEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final companyNameField = TextFormField(
      autofocus: false,
      controller: companyNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value){
        if(value!.isEmpty){
          return "Please enter company name";
        }return null;
      },
      onSaved: (value){
        companyNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.corporate_fare),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Company Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );
    final founderNameField = TextFormField(
      autofocus: false,
      controller: founderNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value){
        if(value!.isEmpty){
          return "Please enter founder name";
        }return null;
      },
      onSaved: (value){
        founderNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Founder Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );
    final phoneNumberField = TextFormField(
      autofocus: false,
      controller: phoneNumberEditingController,
      keyboardType: TextInputType.text,
      validator: (value){
        if(value!.isEmpty){
          return "Please enter phone number";
        }
        if(value.length <10)
        {
          return "Please enter valid phone number";
        }
        return null;
      },
      onSaved: (value){
        phoneNumberEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Contact Number",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );
    final locationField = TextFormField(
      autofocus: false,
      controller: locationEditingController,
      keyboardType: TextInputType.streetAddress,
      validator: (value){
        if(value!.isEmpty){
          return "Please enter location";
        }return null;
      },
      onSaved: (value){
        locationEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.location_on),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Company Location",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );
    final companyCINField = TextFormField(
      autofocus: false,
      controller: CINEditingController,
      keyboardType: TextInputType.text,
      validator: (value){
        if(value!.isEmpty){
          return "Please enter company CIN";
        }return null;
      },
      onSaved: (value){
        CINEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Company CIN",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );
    Future createCompany(Company company) async {
      final docUser = FirebaseFirestore.instance.collection('details').doc(CINEditingController.text);
      company.id = docUser.id;
      final json = company.toJson();
      await docUser.set(json);
    }
    final registerButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          final company = Company(company_name: companyNameEditingController.text, founder: founderNameEditingController.text,location: locationEditingController.text,cin: CINEditingController.text, phone: phoneNumberEditingController.text);
          createCompany(company);
          if(_formkey.currentState!.validate()){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> SigninScreen()));
            return;
          }
          else{ print("Unsuccessful");}
          },
        child: Text("Register",textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
        color: Colors.blueAccent,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Company Registration'),),
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
            SizedBox(height: 150,
                child: Image.asset("assets/logo.png",
                  fit: BoxFit.contain,)),

            SizedBox(height: 45),
            companyNameField,
            SizedBox(height: 15),
            founderNameField,
            SizedBox(height: 15),
            phoneNumberField,
            SizedBox(height: 15),
            companyCINField,
            SizedBox(height: 15),
            locationField,
            SizedBox(height: 25),
            registerButton,

          ],
        ),
      ),
    ),
    ),
    ),)
    );
  }
}
class Company{
  late String id;
  late final String company_name;
  late final String founder;
  late final String location;
  late final String cin;
  late final String phone;
  Company({this.id = '', required this.company_name,required this.founder,required this.location,
    required this.cin,required this.phone});
  Map<String,dynamic> toJson() => {
    'id':cin,'company_name': company_name,'founder': founder,'location': location, 'cin': cin,
    'phone': phone };
}