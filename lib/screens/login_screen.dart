import 'package:flutter/material.dart';
import 'package:chatapp/Buttonself.dart';
import 'package:chatapp/constans.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email, password;
  bool k = false, cir = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
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
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
              },
              decoration: kInputdecor.copyWith(hintText: "Enter your mail"),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
              decoration: kInputdecor.copyWith(hintText: "Enter your password"),
            ),
            SizedBox(
              height: 24.0,
            ),
            Logreg(Colors.lightBlueAccent, "Login", () async {
              try {
                final user = await _auth.signInWithEmailAndPassword(
                    email: email, password: password);

                if (user != null) {
                  Navigator.pushNamed(context, '/chat');
                }
              } catch (e) {
                print(e);
                setState(() {
                  k = true;
                });
              }
            }),
            SizedBox(height: 30),
            Visibility(
              visible: k,
              child: Text("Password incorrect please try again",
                  style: TextStyle(
                    color: Colors.red,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
