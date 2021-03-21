import 'package:flutter/material.dart';
import 'package:istishara/database.dart';
import 'package:istishara/displayOfferedHelp.dart';

import '../post.dart';

// ignore: must_be_immutable
class OfferPage extends StatefulWidget {
  final Post post;
  OfferPage(this.post);
  @override
  OfferPageState createState() => OfferPageState();
}

class OfferPageState extends State<OfferPage> {
  List<dynamic> uidName = [];

  void updateUidName() {
    getUidName(this.widget.post).then((uidName) {
      setState(() {
        this.uidName = uidName;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    updateUidName();
    print(this.uidName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text("Offered Help")),
      body: DisplayOfferedHelp(this.uidName),
    );
  }
}
