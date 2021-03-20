import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:istishara/database.dart';

import '../post.dart';
import '../textInput.dart';
import 'postListClient.dart';

class QuestionsArchitecture extends StatefulWidget {
  final User user;

  QuestionsArchitecture(this.user);
  @override
  QuestionsArchitectureState createState() => QuestionsArchitectureState();
}

class QuestionsArchitectureState extends State<QuestionsArchitecture> {
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
              child: PostListClient(this.posts, widget.user, 'Architecture')),
          TextInputWidget(this.newPost),
        ]));
  }
}
