//Display Chat Messages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:istishara/Widgets/chatBubble.dart';

import '../Classes/message.dart';

// ignore: must_be_immutable
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
      reverse: true,
      scrollDirection: Axis.vertical,
      itemCount: this.widget.messages.length,
      itemBuilder: (context, index) {
        List<dynamic> l = widget.messages.reversed.toList();
        var text = l[index]['content'];
        var time = l[index]['createdAt'].toDate();
        var dateFormatted = DateFormat.yMd().add_jm().format(time).toString();
        var uid = l[index]['uidUser'];
        Message msg = new Message(text: text, time: dateFormatted);
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
