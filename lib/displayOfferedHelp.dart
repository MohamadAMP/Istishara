import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:istishara/professionalProfile.dart';
import 'package:istishara/professionalProfileHelp.dart';

// ignore: must_be_immutable
class DisplayOfferedHelp extends StatefulWidget {
  final List<dynamic> uidName;

  DisplayOfferedHelp(this.uidName);

  @override
  _DisplayOfferedHelpState createState() => _DisplayOfferedHelpState();
}

class _DisplayOfferedHelpState extends State<DisplayOfferedHelp> {
  List<String> names = [];
  final dbRef = FirebaseDatabase.instance.reference();
  DataSnapshot snapshot;
  // List uidName = [];
  Map<dynamic, dynamic> values;
  String key;

  // Future<List> updateNames() async {
  //   List<dynamic> uidName = [];
  //   widget.uids.forEach((uid) async => {
  //         snapshot = await dbRef
  //             .child('users/')
  //             .orderByChild('uid')
  //             .equalTo(uid)
  //             .once(),
  //         if (snapshot.value != null)
  //           {
  //             values = snapshot.value,
  //             key = values.keys.first,
  //             uidName.add([values[key]['uid'], values[key]['name']]),
  //           }
  //       });
  //   return uidName;
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   updateNames();
  // }

  void post(Function callBack) {
    this.setState(() {
      callBack();
    });
  }

  void click(uid) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProfessionalProfileHelp(uid)));
  }

  @override
  Widget build(BuildContext context) {
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
