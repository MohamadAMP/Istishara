import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:istishara/post.dart';

import 'homePages/offeredHelpList.dart';

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
  final dbRef = FirebaseDatabase.instance.reference();
  DataSnapshot snapshot;
  List uidName = [];
  Map<dynamic, dynamic> values;
  String key;

  void post(Function callBack) {
    this.setState(() {
      callBack();
    });
  }

  void updateNames(Post post) async {
    List<dynamic> uidName = [];
    post.usersAnswered.forEach((uid) async => {
          snapshot = await dbRef
              .child('users/')
              .orderByChild('uid')
              .equalTo(uid)
              .once(),
          if (snapshot.value != null)
            {
              values = snapshot.value,
              key = values.keys.first,
              uidName.add([values[key]['uid'], values[key]['name']]),
            }
        });
    setState(() {
      this.uidName = uidName;
    });
  }

  void _offerhelpbuttonpressed(Post post) {
    setState(() {
      updateNames(post);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => OfferPage(this.uidName)));
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
                Row(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: TextButton(
                        child: Text(
                            "Offers: " + post.usersAnswered.length.toString()),
                        onPressed: () => {_offerhelpbuttonpressed(post)},
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.orange,
                          padding: EdgeInsets.all(5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                      )),
                ]),
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
