import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:istishara/chatBubble.dart';

import 'message.dart';

class DisplayMessages extends StatefulWidget {
  final List<dynamic> messages;
  String uid;

  DisplayMessages(this.messages, this.uid);
  @override
  _DisplayMessagesState createState() => _DisplayMessagesState();
}

class _DisplayMessagesState extends State<DisplayMessages> {
  User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: this.widget.messages.length,
      itemBuilder: (context, index) {
        var text = widget.messages[index]['content'];
        var time = widget.messages[index]['createdAt'].toDate().toString();
        var uid = widget.messages[index]['uid'];
        Message msg = new Message(text: text, time: time);
        if (uid == user.uid) {
          return Align(
            alignment: Alignment.centerRight,
            child: ListTile(
              title: chatBubble(msg: msg, isSender: true),
            ),
          );
        } else {
          return Align(
            alignment: Alignment.centerRight,
            child: ListTile(
              title: chatBubble(msg: msg, isSender: false),
            ),
          );
        }
      },
    );
  }
}
