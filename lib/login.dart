import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:istishara/auth.dart';
import 'package:istishara/categorySelection.dart';
import 'package:istishara/selectRole.dart';

import 'database.dart';

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
  Set users;

  void updateUsers() {
    getAllUsers().then((users) => {
          this.setState(() {
            this.users = users;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    signOut();
    updateUsers();
  }

  // bool contains(User user) {
  //   print(
  //       users.where((item) => item.uid == user.uid && item.role == 'Client') !=
  //           null);
  //   return users
  //           .where((item) => item.uid == user.uid && item.role == 'Client') !=
  //       null;
  // }

  void click() {
    signInWithGoogle().then((user) => {
          this.user = user,
          // if (contains(user))
          //   {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => CategorySelection(user)))
          //   },
          // if (!contains(user))
          //   {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => RoleSelection(user)))
          //   }
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RoleSelection(user)))
        });
  }

  Widget loginButton() {
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
