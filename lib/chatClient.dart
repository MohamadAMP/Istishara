import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:istishara/chatFirestore.dart';
import 'package:istishara/displayChatMessages.dart';
import 'package:rating_dialog/rating_dialog.dart';
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
  var firstPress = true;

  void _showRatingDialog() {
    final _dialog = RatingDialog(
      // your app's name?
      title: 'Istishara',
      // encourage your user to leave a high rating?
      message: 'Tap a star to set your rating.',
      // your app's logo?
      image: Image.asset("assets/istisharaphoto.jpeg"),
      submitButton: 'Submit',
      onSubmitted: (response) {
        print('rating: ${response.rating}, comment: ${response.comment}');
      },
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) => _dialog,
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You have already rated this user'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Center(child: Text(widget.name)), actions: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.star),
                  onPressed: () {
                    if (firstPress == true) {
                      _showRatingDialog();
                      firstPress = false;
                    } else {
                      _showMyDialog();
                    }
                  }),
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
