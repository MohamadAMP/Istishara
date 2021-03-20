import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:istishara/displayUserQuestions.dart';
import 'package:istishara/post.dart';

import 'package:istishara/database.dart';

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

  void newPost(String text) {
    var post = new Post(
        text, widget.user.displayName, 'Architecture', widget.user.uid);
    post.setId(savePost(post));
    this.setState(() {
      posts.add(post);
      updatePosts();
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
        appBar: AppBar(
          title: Text('Istishara'),
        ),
        body: Column(children: <Widget>[
          Expanded(
              child: DisplayUserQuestions(
                  this.posts, widget.user, 'Architecture')),
        ]));
  }
}
