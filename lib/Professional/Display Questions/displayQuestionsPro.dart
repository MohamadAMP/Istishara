//Base Page for Displaying Questions

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:istishara/Professional/aboutUsPro.dart';
import 'package:istishara/Services/Database/database.dart';
import 'package:istishara/Services/Database/firestore.dart';
import 'package:rating_dialog/rating_dialog.dart';
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

  void _showRatingDialog() {
    final _dialog = RatingDialog(
      // your app's name?
      title: 'Istishara',
      // encourage your user to leave a high rating?
      message: 'Tap a star to set your rating.',
      // your app's logo?
      image: Image.asset("assets/istisharaphoto.jpeg"),
      submitButton: 'Submit',
      onSubmitted: (response) {
        addAppRating(widget.user.uid, response.comment, response.rating);
      },
    );
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _dialog,
    );
  }

  void _showAboutDialog() {
    final _aboutdialog = AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        title: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("About Us"),
              SizedBox(
                width: 130,
              ),
              IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ]),
        content: Text(
          "Istishara is a platform that was made to link professionals in a specific field to clients who need advice. The app is mostly a public forum of questions where clients post their questions in specific categories, then professionals select the questions they want to answer so they can chat with clients who posted them in a private chat.",
          textAlign: TextAlign.center,
        ));
    showDialog(context: context, builder: (context) => _aboutdialog);
  }

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
                  leading: Icon(Icons.home, size: 30),
                  title: Text('Home',
                      style: TextStyle(
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
                    leading: Icon(Icons.info, size: 30),
                    title: Text('About Us',
                        style: TextStyle(
                          fontSize: 18,
                        )),
                    onTap: () {
                      _showAboutDialog();
                    }),
                ListTile(
                  leading: Icon(Icons.star, size: 30),
                  title: Text('Rate Us',
                      style: TextStyle(
                        fontSize: 18,
                      )),
                  onTap: () {
                    _showRatingDialog();
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
        appBar: AppBar(title: Text('Istishara')),
        body: Column(children: <Widget>[
          Expanded(child: PostList(this.posts, widget.user, widget.type)),
        ]));
  }
}
