//Displays Questions based on the chosen category

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Classes/post.dart';

// ignore: must_be_immutable
class PostListClient extends StatefulWidget {
  String type;
  final User user;
  final List<Post> listItems;

  PostListClient(this.listItems, this.user, this.type);

  @override
  _PostListClientState createState() => _PostListClientState();
}

class _PostListClientState extends State<PostListClient> {
  void post(Function callBack) {
    this.setState(() {
      callBack();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.widget.listItems.length,
      // ignore: missing_return
      itemBuilder: (context, index) {
        var post = this.widget.listItems[index];
        if (post.type == widget.type) {
          return Card(
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
                        "Offered help: " + post.usersAnswered.length.toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    ),
                  ],
                )
              ],
            ),
          );
        } else {
          return SizedBox(
            height: 0,
          );
        }
      },
    );
  }
}
