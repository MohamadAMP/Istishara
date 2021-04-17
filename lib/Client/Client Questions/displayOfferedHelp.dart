//Displays All Advisors That Offered Help On A Certain Question

import 'package:flutter/material.dart';
import 'package:istishara/Common%20FIles/baseProfessionalProfile.dart';

// ignore: must_be_immutable
class DisplayOfferedHelp extends StatefulWidget {
  final List<dynamic> uidName;

  DisplayOfferedHelp(this.uidName);

  @override
  _DisplayOfferedHelpState createState() => _DisplayOfferedHelpState();
}

class _DisplayOfferedHelpState extends State<DisplayOfferedHelp> {
  List<dynamic> uidName = [];

  void post(Function callBack) {
    this.setState(() {
      callBack();
    });
  }

  @override
  void initState() {
    super.initState();
    this.uidName = widget.uidName;
    print(this.uidName);
    print(widget.uidName);
  }

  void click(uid) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProfessionalProfileHelp(uid)));
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
                    ))
              ],
            ),
          );
        },
      );
    }
  }
}
