//Displays Questions based on the chosen category

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:istishara/Services/Database/database.dart';
import '../../Classes/post.dart';
import 'offeredHelpOther.dart';

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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OfferPageOther(this.uidName)));
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
        if (post.type == widget.type) {
          return Card(
              shape: new RoundedRectangleBorder(
                  side: new BorderSide(color: Colors.grey[400], width: 2.0),
                  borderRadius: BorderRadius.circular(4.0)),
              child: Row(children: <Widget>[
                Expanded(
                    child: ListTile(
                  title: Text(post.body),
                  subtitle: Text(post.author),
                )),
                Row(
                  children: <Widget>[
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
                  ],
                ),
              ]));
        } else {
          return SizedBox(
            height: 0,
          );
        }
      },
    );
  }
}
