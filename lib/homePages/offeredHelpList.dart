import 'package:flutter/material.dart';
import 'package:istishara/displayOfferedHelp.dart';

// ignore: must_be_immutable
class OfferPage extends StatefulWidget {
  List<dynamic> uidNames;
  OfferPage(this.uidNames);
  @override
  OfferPageState createState() => OfferPageState();
}

class OfferPageState extends State<OfferPage> {
  List<dynamic> uidName = [];
  // final dbRef = FirebaseDatabase.instance.reference();
  // DataSnapshot snapshot;
  // List uidName = [];
  // Map<dynamic, dynamic> values;
  // String key;

  // void updateNames() async {
  //   widget.post.usersAnswered.forEach((uid) async => {
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
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   updateNames();
  // }
  void updateUidName() {
    setState(() {
      this.uidName = this.widget.uidNames;
    });
  }

  @override
  void initState() {
    super.initState();
    updateUidName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text("Offered Help")),
      body: DisplayOfferedHelp(this.uidName),
    );
  }
}
