import 'package:flutter/material.dart';
import 'package:light/components/round_button.dart';
import 'package:light/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool spinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                  style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextfield.copyWith(hintText: 'Enter your Email', hintStyle: TextStyle(color: Colors.grey))
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextfield.copyWith(hintText: 'Enter your Password', hintStyle: TextStyle(color: Colors.grey))
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundButton(
                color: Colors.lightBlueAccent,
                title: 'Log in',
                onpressed: () async{
                  setState(() {
                    spinner = true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user!=null){
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                      spinner = false;
                    });
                  }
                  catch (e){
                    Alert(
                      context: context,
                      title: 'OOPS',
                      desc: 'Wrong Cred.!!',
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
