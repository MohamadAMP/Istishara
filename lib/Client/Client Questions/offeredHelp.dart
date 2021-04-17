//Offered Help Base Page

import 'package:flutter/material.dart';
import 'package:istishara/Client/Client%20Questions/displayOfferedHelp.dart';

// ignore: must_be_immutable
class OfferPage extends StatefulWidget {
  final List<dynamic> uidName;
  OfferPage(this.uidName);
  @override
  OfferPageState createState() => OfferPageState();
}

class OfferPageState extends State<OfferPage> {
  List<dynamic> uidName = [];

  void updateUidName() async {
    setState(() {
      this.uidName = uidName;
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
      body: DisplayOfferedHelp(this.widget.uidName),
    );
  }
}
