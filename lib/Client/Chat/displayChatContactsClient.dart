//Displays All The Clients Contacts

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:istishara/Services/Database/firestore.dart';
import 'chatClient.dart';

// ignore: must_be_immutable
class DisplayChatContacts extends StatefulWidget {
  List<dynamic> usersNamesPosts;
  List<dynamic> usersAnswered;
  String uid;
  List<dynamic> chats;
  DisplayChatContacts(
      this.usersNamesPosts, this.usersAnswered, this.uid, this.chats);

  @override
  _DisplayChatContactsState createState() => _DisplayChatContactsState();
}

class _DisplayChatContactsState extends State<DisplayChatContacts> {
  Future<void> click(uidReceived, String name) async {
    String uidComb = uidReceived + widget.uid;
    CollectionReference chat = FirebaseFirestore.instance.collection('chats');
    var snapshot = await chat.doc(uidComb).get();
    //print(snapshot.data());
    if (snapshot.data() != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ChatDisplayPage(name, uidComb, widget.uid, uidReceived)));
    }
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.usersAnswered);
    //print(widget.usersNamesPosts);
    return ListView.builder(
        itemCount: this.widget.usersNamesPosts.length,
        // ignore: missing_return
        itemBuilder: (context, index) {
          var name = (this.widget.usersNamesPosts[index][0]);
          var post = (this.widget.usersNamesPosts[index][1]);
          var uidOther = this.widget.usersAnswered[index];
          return Card(
            shape: new RoundedRectangleBorder(
                side: new BorderSide(color: Colors.grey[400], width: 2.0),
                borderRadius: BorderRadius.circular(4.0)),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: ListTile(
                  title: Text(name),
                  subtitle: Text("Question: " + post),
                )),
                Row(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: TextButton(
                        child: Text("Chat"),
                        onPressed: () => {this.click(uidOther, name)},
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
        });
  }
}
