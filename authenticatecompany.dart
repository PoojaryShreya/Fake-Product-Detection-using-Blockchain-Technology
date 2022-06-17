import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';
import 'signup.dart';

class AuthenticateState extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}
class _AuthenticateState extends State<AuthenticateState> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  void sendOTP() async {
    EmailAuth emailAuth = EmailAuth(sessionName: "Test Session");
    var res = await emailAuth.sendOtp(recipientMail: _emailController.text);
    if (res) {
      print("OTP Sent");
    }
    else {
      print("We couldn't send OTP");
    }
  }
  void verifyOTP() {
    EmailAuth emailAuth = EmailAuth(sessionName: " Session Name");
    var res = emailAuth.validateOtp(
        recipientMail: _emailController.text, userOtp: _otpController.text);
    if (res) {
      print("OTP Verified");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) =>  SignupScreen(),
          ),
              (Route<dynamic> route) => false
      );
    }
    else {
      print("Invalid OTP");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Verify Email',textAlign: TextAlign.center,),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Container(
            margin: EdgeInsets.only(top: 60),
            child: Center(
              child: Text(
                'Email Authentication',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
            ),
          ),
          SizedBox(height: 40.0,),
          Padding(padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: 'Email Address',
                        labelText: "Email",
                        suffixIcon: TextButton(
                          child: Text("Send OTP"),
                          onPressed: () => sendOTP(),
                        )),
                  ),
                  SizedBox(height: 30.0,),
                  TextField(controller: _otpController,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Enter OTP',
                        labelText: "OTP",
                      )
                  ),
                  SizedBox(height: 30.0,),
                  ElevatedButton(
                    child: Text("Verify OTP"),
                    onPressed: () => verifyOTP(),
                  )
                ],
              )
          ),
        ],
      ),
    );
  }
}

