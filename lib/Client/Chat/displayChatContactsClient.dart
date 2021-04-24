//Displays All The Clients Contacts

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

    return ListView.separated(
      itemCount: this.widget.usersNamesPosts.length,
      // ignore: missing_return
      itemBuilder: (context, index) {
        var name = (this.widget.usersNamesPosts[index][0]);
        //print(name);
        var post = (this.widget.usersNamesPosts[index][1]);
        var uidOther = (this.widget.usersNamesPosts[index][2]);
        var link = (this.widget.usersNamesPosts[index][3]);
        var pic = Image.network(
          link,
        );
        return InkWell(
          onTap: () {
            this.click(uidOther, name);
          },
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(
                  image: pic.image,
                  height: 60,
                  width: 60,
                  fit: BoxFit.fill,
                ),
              ),

              //Image.asset("asset/blank_card.png",height: 30,width: 30),

              Expanded(
                  child: ListTile(
                title: Text(name),
                subtitle: Text("Question: " + post),
              )),
            ],
          ),
        );
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
