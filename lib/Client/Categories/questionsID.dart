//Base Interior Design Category

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:istishara/Services/Database/database.dart';

import '../../Classes/post.dart';
import '../../Widgets/textInput.dart';
import 'postListClient.dart';

class QuestionsID extends StatefulWidget {
  final User user;

  QuestionsID(this.user);
  @override
  QuestionsIDState createState() => QuestionsIDState();
}

class QuestionsIDState extends State<QuestionsID> {
  List<Post> posts = [];

  void updatePosts() {
    getAllPosts().then((posts) => {
          this.setState(() {
            this.posts = posts;
          })
        });
  }

  void newPost(String text) {
    var post = new Post(text, widget.user.displayName, 'Interior Design',
        widget.user.uid, DateTime.now().microsecondsSinceEpoch.toString());
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
              child:
                  PostListClient(this.posts, widget.user, 'Interior Design')),
          TextInputWidget(this.newPost),
        ]));
  }
}
