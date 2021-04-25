//Base Login Page

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:istishara/Services/Authentication/auth.dart';
import 'package:istishara/Professional/baseProfessionalHomepage.dart';
import 'package:istishara/Services/Database/firestore.dart';
import 'package:istishara/Services/Login/selectRole.dart';

import '../../Client/baseClientHomepage.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Istishara')),
      ),
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  User user;
  final dbRef = FirebaseDatabase.instance.reference();
  DataSnapshot snapshot;
  List uidRole = [];
  Map<dynamic, dynamic> values;
  String key;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    signOut();
  }

  void click() {
    signInWithGoogle().then((user) async => {
          this.user = user,
          saveDeviceToken(user.uid),
          await addOrUpdateProfilePic(user.uid, user.photoURL),
          snapshot = await dbRef
              .child('users/')
              .orderByChild('uid')
              .equalTo(user.uid)
              .once(),
          if (snapshot.value == null)
            {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => RoleSelection(user)))
            },
          if (snapshot.value != null)
            {
              values = snapshot.value,
              key = values.keys.first,
              uidRole.add(values[key]['uid']),
              uidRole.add(values[key]['role']),
              if (uidRole[0] == user.uid && uidRole[1] == 'Client')
                {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BaseClientHomepage(user)))
                },
              if (uidRole[0] == user.uid && uidRole[1] != 'Client')
                {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BaseProfessionalHomepage(user, uidRole[1])))
                },
            }
        });
  }

  Widget loginButton() {
    // ignore: deprecated_member_use
    return OutlineButton(
      onPressed: this.click,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      splashColor: Colors.grey[600],
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image(image: AssetImage('assets/google_logo.png'), height: 35),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(color: Colors.grey, fontSize: 25),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 35),
        Container(
          height: 300,
          child: Image(
            image: AssetImage('assets/istisharaphoto.jpeg'),
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: 35),
        RichText(
          text: TextSpan(
              text: "Welcome to ",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                    text: "Istishara",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange))
              ]),
        ),
        SizedBox(height: 25),
        Container(
          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
          child: Text(
            "Get your Best Istishara! Join the Istishara community, home to millions of advisors.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          ),
        ),
        SizedBox(height: 25),
        Container(child: loginButton())
      ],
    );
  }
}
