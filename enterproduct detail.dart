import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:majorproject/generateqr.dart';
import 'package:majorproject/register.dart';
class EnterProduct extends StatefulWidget {
  @override
  _EnterProductState createState() => _EnterProductState();
}
class _EnterProductState extends State<EnterProduct> {
  CollectionReference productdetail = FirebaseFirestore.instance.collection("details/");
  final _formkey = GlobalKey<FormState>();
  final brandNameController = new TextEditingController();
  final productNameController = new TextEditingController();
  final productIdController = new TextEditingController();
  final productTypeController = new TextEditingController();
  final colorController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final brandNameField = TextFormField(
      autofocus: false,
      controller: brandNameController,
      keyboardType: TextInputType.name,
      validator: (value){
        if(value!.isEmpty){
          return "Please enter brand name";
        }return null;
      },
      onSaved: (value){
        brandNameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          //prefixIcon: Icon(Icons.),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Brand Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );
    final productNameField = TextFormField(
      autofocus: false,
      controller: productNameController,
      keyboardType: TextInputType.name,
      validator: (value){
        if(value!.isEmpty){
          return "Please enter product name";
        }return null;
      },
      onSaved: (value){
        productNameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          //prefixIcon: Icon(Icons.p),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Product Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );
    final productIdField = TextFormField(
      autofocus: false,
      controller: productIdController,
      keyboardType: TextInputType.text,
      validator: (value){
        if(value!.isEmpty){
          return "Please enter product ID";
        }
        return null;
      },
      onSaved: (value){
        productIdController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          //prefixIcon: Icon(Icons.phone),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Product ID",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );
    final productTypeField = TextFormField(
      autofocus: false,
      controller: productTypeController,
      keyboardType: TextInputType.name,
      validator: (value){
        if(value!.isEmpty){
          return "Please enter Product Type";
        }return null;
      },
      onSaved: (value){
        productTypeController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          //prefixIcon: Icon(Icons.location_on),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Product Type",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );
    final colorField = TextFormField(
      autofocus: false,
      controller: colorController,
      keyboardType: TextInputType.text,
      validator: (value){
        if(value!.isEmpty){
          return "Please enter color of product";
        }return null;
      },
      onSaved: (value){
        colorController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          //prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Product Color",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );
    Future createCompany(Product product) async {
      final docUser = FirebaseFirestore.instance.collection('details/').doc(productIdController.text);
      product.id = docUser.id;
      final json = product.toJson();
      await docUser.set(json);
    }
    final registerButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          final product = Product(BrandName: brandNameController.text, ProductName: productNameController.text,ProductId: productIdController.text,ProductType: productTypeController.text, Color: colorController.text);
          createCompany(product);
          if(_formkey.currentState!.validate()){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GenerateQR()));
            return;
          }
          else{ print("Unsuccessful");}
        },
        child: Text("Upload",textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
        color: Colors.blueAccent,
      ),
    );
    return Scaffold(
        appBar: AppBar(
          title: Text('Product Registration'),),
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

                      SizedBox(height: 45),
                      brandNameField,
                      SizedBox(height: 15),
                      productNameField,
                      SizedBox(height: 15),
                      productIdField,
                      SizedBox(height: 15),
                      productTypeField,
                      SizedBox(height: 15),
                      colorField,
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
class Product{
  late String id;
  //late final String cin;
  late final String BrandName;
  late final String ProductName;
  late final String ProductId;
  late final String ProductType;
  late final String Color
  ;
  Product({this.id = '' ,required this.BrandName,required this.ProductName,required this.ProductId,
    required this.ProductType,required this.Color});
  Map<String,dynamic> toJson() => {
    'id':ProductId,'Brand_Name': BrandName,'Product_Name': ProductName,'Product_Id': ProductId,
    'Product_Type': ProductType, 'Color': Color };
}