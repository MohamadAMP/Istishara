import 'package:flutter/material.dart';
import 'package:istishara/message.dart';

// ignore: camel_case_types
class chatBubble extends StatelessWidget {
  final Message msg;
  final bool isSender; //true if you are the sender
  chatBubble({this.msg, this.isSender});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 14, right: 120, top: 10, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: (isSender ? Colors.blue[200] : Colors.grey[400]),
        ),
        padding: EdgeInsets.all(16),
        child: IntrinsicHeight(
          child: Column(children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                msg.text,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                msg.time,
                style: TextStyle(fontSize: 14),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
