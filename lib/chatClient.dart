import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:istishara/chatFirestore.dart';
import 'package:istishara/displayChatMessages.dart';

import 'messageForm.dart';

// ignore: must_be_immutable
class ChatDisplayPage extends StatefulWidget {
  String name;
  String docID;
  String uid;
  ChatDisplayPage(this.name, this.docID, this.uid);
  @override
  _ChatDisplayPageState createState() => _ChatDisplayPageState();
}

class _ChatDisplayPageState extends State<ChatDisplayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Center(child: Text(widget.name)), actions: <Widget>[
          Row(
            children: <Widget>[
              IconButton(icon: Icon(Icons.star), onPressed: () {}),
              IconButton(icon: Icon(Icons.person), onPressed: () {}),
            ],
          ),
        ]),
        body: Column(children: <Widget>[
          Expanded(
              child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('chats')
                .doc(widget.docID)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Comparator<dynamic> comp = (a, b) {
                  var adate = a['createdAt'].toDate();
                  var bdate = b['createdAt'].toDate();
                  return adate.compareTo(bdate);
                };
                List<dynamic> msgs = snapshot.data['messages'];
                msgs.sort(comp);
                return DisplayMessages(msgs, widget.uid);
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          )),
          Container(child: MessageForm((value) {
            sendMessage(widget.docID, value, widget.uid);
          }))
        ]));
  }
}
