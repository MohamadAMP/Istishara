//Base Page for Displaying Questions

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:istishara/Professional/aboutUsPro.dart';
import 'package:istishara/Services/Database/database.dart';
import '../../Services/Authentication/auth.dart';
import '../../Services/Login/login.dart';
import '../../Classes/post.dart';
import '../baseProfessionalHomepage.dart';
import 'postListProfessional.dart';

// ignore: must_be_immutable
class MyHomePagePro extends StatefulWidget {
  String type;
  final User user;

  MyHomePagePro(this.user, this.type);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePagePro> {
  List<Post> posts = [];

  void updatePosts() {
    getAllPosts().then((posts) => {
          this.setState(() {
            this.posts = posts;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    updatePosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  leading: Icon(Icons.home,size: 30),
                  title: Text('Home',style: TextStyle(
                    fontSize: 18,
                  )),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BaseProfessionalHomepage(
                                widget.user, widget.type)));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.info,size: 30),
                  title: Text('About Us',style: TextStyle(
                    fontSize: 18,
                  )),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AboutUsPro(widget.type)));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout,size: 30),
                  title: Text('Log Out',style: TextStyle(
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
        appBar: AppBar(title: Text('Istishara')),
        body: Column(children: <Widget>[
          Expanded(child: PostList(this.posts, widget.user, widget.type)),
        ]));
  }
}
