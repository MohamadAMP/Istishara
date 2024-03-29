//Displays All Advisors That Offered Help On A Certain Question

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:istishara/Client/Chat/chatClient.dart';
import 'package:istishara/Common%20FIles/baseProfessionalProfile.dart';
import 'package:istishara/Services/Database/firestore.dart';

// ignore: must_be_immutable
class DisplayOfferedHelp extends StatefulWidget {
  final List<dynamic> uidName;

  DisplayOfferedHelp(this.uidName);

  @override
  _DisplayOfferedHelpState createState() => _DisplayOfferedHelpState();
}

class _DisplayOfferedHelpState extends State<DisplayOfferedHelp> {
  List<dynamic> uidName = [];
  User user = FirebaseAuth.instance.currentUser;

  void post(Function callBack) {
    this.setState(() {
      callBack();
    });
  }

  @override
  void initState() {
    super.initState();
    this.uidName = widget.uidName;
    //print(this.uidName);
    //print(widget.uidName);
  }

  void click(uid) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProfessionalProfileHelp(uid)));
  }

  Future<void> chat(uid, name) async {
    String uidComb = uid + user.uid;
    CollectionReference chat = FirebaseFirestore.instance.collection('chats');
    var snapshot = await chat.doc(uidComb).get();
    CollectionReference chatList =
        FirebaseFirestore.instance.collection('chatList');
    var snapshotOther = await chatList.doc(uid).get();
    var snapshotUser = await chatList.doc(user.uid).get();
    //print(snapshot.data());
    if (snapshot.data() != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ChatDisplayPage(name, uidComb, user.uid, uid)));
    } else {
      addChat(uidComb);
      if (snapshotUser.data() != null) {
        updateChatList(user.uid, uid);
      } else {
        addChatList(user.uid, "Client");
        updateChatList(user.uid, uid);
      }
      if (snapshotOther.data() != null) {
        updateChatList(uid, user.uid);
      } else {
        addChatList(uid, "Advisor");
        updateChatList(uid, user.uid);
      }
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ChatDisplayPage(name, uidComb, user.uid, uid)));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (this.widget.uidName.length == 0) {
      return Card(
        shape: new RoundedRectangleBorder(
            side: new BorderSide(color: Colors.grey[400], width: 2.0),
            borderRadius: BorderRadius.circular(4.0)),
        child: Row(
          children: <Widget>[
            Expanded(
                child: ListTile(
              title: Text("No one has offered you help yet"),
            )),
          ],
        ),
      );
    } else {
      return ListView.builder(
        itemCount: this.widget.uidName.length,
        itemBuilder: (context, index) {
          var uid = this.widget.uidName[index][0];
          var name = this.widget.uidName[index][1];
          return Card(
            shape: new RoundedRectangleBorder(
                side: new BorderSide(color: Colors.grey[400], width: 2.0),
                borderRadius: BorderRadius.circular(4.0)),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: ListTile(
                  title: Text(name),
                )),
                Padding(
                    padding: EdgeInsets.all(1),
                    child: TextButton(
                      child: Text("Chat"),
                      onPressed: () => {this.chat(uid, name)},
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.orange,
                        padding: EdgeInsets.all(5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.all(20),
                    child: TextButton(
                      child: Text("Go to profile"),
                      onPressed: () => {this.click(uid)},
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.orange,
                        padding: EdgeInsets.all(5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                    )),
              ],
            ),
          );
        },
      );
    }
  }
}
