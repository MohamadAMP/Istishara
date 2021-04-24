import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:istishara/Client/baseClientHomepage.dart';
import 'package:istishara/Services/Authentication/auth.dart';
import 'package:istishara/Services/Login/login.dart';

import 'baseProfessionalHomepage.dart';

class AboutUsPro extends StatelessWidget {
  final type;
  AboutUsPro(this.type);
  User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('About Us')),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Istishara'),
                decoration: BoxDecoration(
                  color: Colors.orange,
                ),
              ),
              ListTile(
                title: Text('Home'),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BaseProfessionalHomepage(this.user, this.type)));
                },
              ),
              ListTile(
                title: Text('About Us'),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AboutUsPro(this.type)));
                },
              ),
              ListTile(
                title: Text('Log Out'),
                onTap: () {
                  signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: Container(child: Text("Fill in later")));
  }
}
