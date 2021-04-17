//Display Questions Based On Advisor's Profession

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Classes/post.dart';

class PostList extends StatefulWidget {
  final type;
  final User user;
  final List<Post> listItems;

  PostList(this.listItems, this.user, this.type);

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  void post(Function callBack) {
    this.setState(() {
      callBack();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.widget.listItems.length,
      itemBuilder: (context, index) {
        var post = this.widget.listItems[index];
        if (post.type == widget.type) {
          return Padding(
              padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
              child: Card(
                shape: new RoundedRectangleBorder(
                    side: new BorderSide(color: Colors.grey[400], width: 2.0),
                    borderRadius: BorderRadius.circular(4.0)),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: ListTile(
                      title: Text(post.body),
                      subtitle: Text(post.author),
                    )),
                    Row(
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Offered help: " +
                                post.usersAnswered.length.toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        ),
                        IconButton(
                            icon: Icon(Icons.inbox),
                            onPressed: () =>
                                this.post(() => post.answerPost(widget.user)),
                            color: post.usersAnswered.contains(widget.user.uid)
                                ? Colors.green
                                : Colors.black)
                      ],
                    )
                  ],
                ),
              ));
        } else {
          return SizedBox(
            height: 0,
          );
        }
      },
    );
  }
}
