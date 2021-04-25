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
  List<dynamic> chats = [];
  List<dynamic> usersAnswered = [];
  List<dynamic> usersNamesPost = [];
  String name = '';
  String post = '';
  List<dynamic> userInfo = [];
  AnimationController controller;

  List link;

  Future<void> getProUsersAnswered() async {
    await getUserChatsbyUid(widget.uid).then((chats) {
      setState(() {
        this.chats = chats;
      });
    });
    //print(this.chats);
    List<dynamic> _usersAnswered = [];
    List<dynamic> _usersNamesPost = [];
    List<dynamic> temp = [];
    await getUsersAnsweredPro(widget.uid).then((uidPosts) {
      uidPosts.forEach((uidPost) async => {
            link = await getProfilePic(uidPost[0]),
            if (chats.contains(uidPost[0]))
              {
                //print(uidPost[0]),
                //print(name),
                print(name),
                temp.add(link[0]),
                temp.add(uidPost[1]),
                temp.add(uidPost[0]),
                temp.add(link[1]),
                print(temp),
                _usersNamesPost.add(temp),
                temp = [],
              }
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
                  ChatDisplayPagePro(name, uidComb, widget.uid, uidReceived)));
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
      return ListView.separated(
        itemCount: this.usersNamesPost.length,
        // ignore: missing_return
        itemBuilder: (context, index) {
          var name = this.usersNamesPost[index][0];
          //print(name);
          var post = this.usersNamesPost[index][1];
          var uidOther = this.usersNamesPost[index][2];
          var link = this.usersNamesPost[index][3];
          var pic = Image.network(
            link,
          );
          return InkWell(
              onTap: () {
                this.click(uidOther, name);
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Container(
                  child: Row(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: pic.image
                            )
                        ),
                      ),
                      //Image.asset("asset/blank_card.png",height: 30,width: 30),
                    ),
                    Expanded(
                        child: ListTile(
                      title: Text(name),
                      subtitle: Text("Question: " + post),
                    )),
                  ]),
                ),
              ));
        },
        separatorBuilder: (context, index) {
          return Divider(
            thickness: 1,
            indent: 15,
            endIndent: 15,
            color: Colors.grey,
          );
        },
      );
    }
  }
}
