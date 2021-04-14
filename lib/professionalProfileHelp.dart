import 'package:flutter/material.dart';
import 'package:istishara/database.dart';
import 'package:istishara/professionalProfile.dart';
import 'package:istishara/professionalProfileClient.dart';

class ProfessionalProfileHelp extends StatefulWidget {
  final String uid;

  ProfessionalProfileHelp(this.uid);
  @override
  ProfessionalProfileHelpState createState() => ProfessionalProfileHelpState();
}

class ProfessionalProfileHelpState extends State<ProfessionalProfileHelp> {
  List<dynamic> userData = [];
  String name;
  String type;
  void updateUserData() {
    getUserDataByUid(this.widget.uid).then((userData) {
      setState(() {
        this.userData = userData;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    updateUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      Expanded(child: ProfessionalProfileClient(this.userData)),
    ]));
  }
}
