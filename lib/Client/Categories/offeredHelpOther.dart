import 'package:flutter/material.dart';

import 'displayOfferedHelpOther.dart';

// ignore: must_be_immutable
class OfferPageOther extends StatefulWidget {
  final List<dynamic> uidName;
  OfferPageOther(this.uidName);
  @override
  OfferPageOtherState createState() => OfferPageOtherState();
}

class OfferPageOtherState extends State<OfferPageOther> {
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
      body: DisplayOfferedHelpOther(this.widget.uidName),
    );
  }
}
