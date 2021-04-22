//Chat View For Professional

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:istishara/Common%20FIles/displayChatMessages.dart';
import 'package:istishara/Services/Database/firestore.dart';

import '../../Widgets/messageForm.dart';

// ignore: must_be_immutable
class ChatDisplayPagePro extends StatefulWidget {
  String name;
  String docID;
  String uid;
  String uidReceived;
  ChatDisplayPagePro(this.name, this.docID, this.uid, this.uidReceived);
  @override
  _ChatDisplayPageProState createState() => _ChatDisplayPageProState();
}

class _ChatDisplayPageProState extends State<ChatDisplayPagePro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Center(child: Text(widget.name))),
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
            sendMessage(
              widget.docID,
              value,
              widget.uid,
              widget.uidReceived,
            );
          }))
        ]));
  }
}
