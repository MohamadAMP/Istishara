import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:istishara/database.dart';
import '../auth.dart';
import '../login.dart';
import '../post.dart';
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
        appBar: AppBar(title: Text('Istishara'), actions: <Widget>[
          Row(
            children: <Widget>[
              Container(child: Text('Log out')),
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              )
            ],
          ),
        ]),
        body: Column(children: <Widget>[
          Expanded(child: PostList(this.posts, widget.user, widget.type)),
        ]));
  }
}
