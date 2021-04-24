import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:istishara/Client/baseClientHomepage.dart';
import 'package:istishara/Services/Authentication/auth.dart';
import 'package:istishara/Services/Login/login.dart';

// ignore: must_be_immutable
class AboutUs extends StatelessWidget {
  User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('About Us')),
        drawer: Container(
          width: 300,
          child: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Image.asset("assets/Istishara_logo.png"),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home, size: 30),
                  title: Text('Home',
                      style: TextStyle(
                        fontSize: 18,
                      )),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BaseClientHomepage(this.user)));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.info, size: 30),
                  title: Text('About Us',
                      style: TextStyle(
                        fontSize: 18,
                      )),
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => AboutUs()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout, size: 30),
                  title: Text('Log Out',
                      style: TextStyle(
                        fontSize: 18,
                      )),
                  onTap: () {
                    signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Container(child: Text("Fill in later")));
  }
}
