//Displays All Questions Asked By The User

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:istishara/Classes/post.dart';

import '../../Services/Database/database.dart';
import 'offeredHelp.dart';

// ignore: must_be_immutable
class DisplayUserQuestions extends StatefulWidget {
  final User user;
  final List<Post> listItems;

  DisplayUserQuestions(this.listItems, this.user);

  @override
  _DisplayUserQuestionsState createState() => _DisplayUserQuestionsState();
}

class _DisplayUserQuestionsState extends State<DisplayUserQuestions> {
  List<Post> userPosts = [];
  List<String> names = [];
  List<dynamic> uidName = [];
  String type = '';
  User user = FirebaseAuth.instance.currentUser;

  void post(Function callBack) {
    this.setState(() {
      callBack();
    });
  }

  void getUserType(String uid) async {
    getUserDataByUid(uid).then((value) {
      setState(() {
        type = value[1];
      });
    });
  }

  void updateUidName(Post post) async {
    getUidName(post).then((uidName) {
      setState(() {
        this.uidName = uidName;
      });
    });
  }

  void _offerhelpbuttonpressed(Post post) {
    setState(() {
      updateUidName(post);
      getUserType(user.uid);

      Future.delayed(Duration(seconds: 1), () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => OfferPage(this.uidName)));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.widget.listItems.length,
      // ignore: missing_return
      itemBuilder: (context, index) {
        var post = this.widget.listItems[index];
        if (post.uid == widget.user.uid) {
          return Dismissible(
              direction: DismissDirection.endToStart,
              key: ValueKey<dynamic>(post),
              background: Container(
                padding: EdgeInsets.all(10),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Swipe to delete",
                      style: TextStyle(
                          //add rating in the future
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )),
                color: Colors.red,
              ),
              onDismissed: (DismissDirection direction) {
                setState(() {
                  this.widget.listItems.removeAt(index);
                  deletePost(post.createdAt);
                  final snackBar = new SnackBar(
                    content: Text("Post deleted"),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        this.widget.listItems.add(post);
                        post.setId(savePost(post));
                        setState(() {});
                      },
                    ),
                  );
                  // ignore: deprecated_member_use
                  Scaffold.of(context).showSnackBar(snackBar);
                });
              },
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
                    Row(children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(20),
                          child: TextButton(
                            child: Text("Offers: " +
                                post.usersAnswered.length.toString()),
                            onPressed: () => {_offerhelpbuttonpressed(post)},
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.orange,
                              padding: EdgeInsets.all(5),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                            ),
                          )),
                    ]),
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
