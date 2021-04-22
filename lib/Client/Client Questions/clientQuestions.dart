//Client Questions Base Page

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:istishara/Services/Authentication/auth.dart';
import 'package:istishara/Client/Client%20Questions/displayUserQuestions.dart';
import 'package:istishara/Classes/post.dart';

import 'package:istishara/Services/Database/database.dart';

import '../../Services/Login/login.dart';

class ClientQuestions extends StatefulWidget {
  final User user;

  ClientQuestions(this.user);
  @override
  ClientQuestionsState createState() => ClientQuestionsState();
}

class ClientQuestionsState extends State<ClientQuestions> {
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
        appBar: AppBar(title: Text('Questions'), actions: <Widget>[
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
          Expanded(child: DisplayUserQuestions(this.posts, widget.user)),
        ]));
  }
}