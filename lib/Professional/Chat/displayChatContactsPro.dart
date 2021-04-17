//Displays All Chat Contacts For Professional

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:istishara/Services/Database/firestore.dart';
import 'chatPro.dart';
import '../../Services/Database/database.dart';

// ignore: must_be_immutable
class DisplayChatContactsPro extends StatefulWidget {
  String uid;
  DisplayChatContactsPro(this.uid);

  @override
  _DisplayChatContactsProState createState() => _DisplayChatContactsProState();
}

class _DisplayChatContactsProState extends State<DisplayChatContactsPro>
    with TickerProviderStateMixin {
  List<dynamic> usersAnswered = [];
  List<dynamic> usersNamesPost = [];
  String name = '';
  String post = '';
  List<dynamic> userInfo = [];
  AnimationController controller;

  Future<void> getProUsersAnswered() async {
    List<dynamic> _usersAnswered = [];
    List<dynamic> _usersNamesPost = [];
    List<dynamic> temp = [];
    await getUsersAnsweredPro(widget.uid).then((uidPosts) {
      uidPosts.forEach((uidPost) async => {
            name = await getNameByUid(uidPost[0]),
            print(uidPost[0]),
            print(name),
            post = uidPost[1],
            temp.add(name),
            temp.add(post),
            _usersNamesPost.add(temp),
            _usersAnswered.add(uidPost[0]),
            temp = [],
          });
      setState(() {
        this.usersAnswered = _usersAnswered;
        this.usersNamesPost = _usersNamesPost;
      });
    });
  }

  Future<void> click(uidReceived, String name) async {
    String uidComb = widget.uid + uidReceived;
    CollectionReference chat = FirebaseFirestore.instance.collection('chats');
    var snapshot = await chat.doc(uidComb).get();

    if (snapshot.data() != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ChatDisplayPagePro(name, uidComb, widget.uid)));
    } else {
      addChat(uidComb);
      print('else statement');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ChatDisplayPagePro(name, uidComb, widget.uid)));
    }
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
    getProUsersAnswered();
  }

  @override
  Widget build(BuildContext context) {
    if (usersNamesPost.isEmpty) {
      return Center(
          child: CircularProgressIndicator(
        value: controller.value,
      ));
    } else {
      return ListView.builder(
          itemCount: this.usersNamesPost.length,
          // ignore: missing_return
          itemBuilder: (context, index) {
            var name1 = (this.usersNamesPost[index][0]);
            var post = (this.usersNamesPost[index][1]);
            var uidOther = this.usersAnswered[index];
            return Card(
              shape: new RoundedRectangleBorder(
                  side: new BorderSide(color: Colors.grey[400], width: 2.0),
                  borderRadius: BorderRadius.circular(4.0)),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: ListTile(
                    title: Text(name1),
                    subtitle: Text("Question: " + post),
                  )),
                  Row(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: TextButton(
                          child: Text("Chat"),
                          onPressed: () => {this.click(uidOther, name1)},
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
            );
          });
    }
  }
}
