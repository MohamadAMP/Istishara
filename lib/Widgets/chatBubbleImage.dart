import 'package:flutter/material.dart';
import 'package:istishara/Classes/message.dart';

// ignore: camel_case_types
class chatBubbleImage extends StatelessWidget {
  final String time;
  final bool isSender; //true if you are the sender
  final String sentImage;
  chatBubbleImage({this.time, this.isSender, this.sentImage});

  @override
  Widget build(BuildContext context) {
    var pic = Image.network(this.sentImage);
    if (isSender == true) {
      return Container(
        padding: EdgeInsets.only(left: 120, right: 10, top: 10, bottom: 10),
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
                child: pic,
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  time,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ]),
          ),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.only(left: 10, right: 120, top: 10, bottom: 10),
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
                child: pic,
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  time,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ]),
          ),
        ),
      );
    }
  }
}
