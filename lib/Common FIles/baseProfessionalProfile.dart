//Base Advisor Profile

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:istishara/Services/Database/database.dart';
import 'package:istishara/Professional/Profile/professionalProfilePro.dart';
import 'package:istishara/Client/professionalProfileClient.dart';
import 'package:istishara/Services/Database/firestore.dart';

class ProfessionalProfileHelp extends StatefulWidget {
  final String uid;

  ProfessionalProfileHelp(this.uid);
  @override
  ProfessionalProfileHelpState createState() => ProfessionalProfileHelpState();
}

class ProfessionalProfileHelpState extends State<ProfessionalProfileHelp>
    with TickerProviderStateMixin {
  User user = FirebaseAuth.instance.currentUser;
  List<dynamic> userData = [];
  List<dynamic> currentUserData = [];
  int jobsDone;
  double rating;
  List<dynamic> reviews = [];
  AnimationController controller;

  Future<void> updateUserData() async {
    await getUserDataByUid(this.widget.uid).then((userData) {
      setState(() {
        this.userData = userData;
      });
    });
    await getUserDataByUid(user.uid).then((userData) {
      setState(() {
        this.currentUserData = userData;
      });
    });
  }

  Future<void> getUserRating() async {
    await getUserRatingByUid(widget.uid).then((value) {
      setState(() {
        rating = value.elementAt(0);
        jobsDone = value.elementAt(1);
      });
    });
  }

  Future<void> getUserReviews() async {
    await getUserReviewsbyUid(widget.uid).then((value) {
      setState(() {
        this.reviews = value;
      });
    });
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    controller.forward();
    super.initState();
    updateUserData();
    getUserRating();
    getUserReviews();
  }

  @override
  Widget build(BuildContext context) {
    if (this.currentUserData.isEmpty) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Profile"),
          ),
          body: Center(
              child: CircularProgressIndicator(
            value: controller.value,
          )));
    }
    if (this.currentUserData.elementAt(1) == 'Client') {
      return Scaffold(
          body: Column(children: <Widget>[
        Expanded(
            child: ProfessionalProfileClient(
                this.userData, this.jobsDone, this.rating, this.reviews)),
      ]));
    } else {
      return Scaffold(
          body: Column(children: <Widget>[
        Expanded(
            child: ProfessionalProfile(
                this.userData, this.jobsDone, this.rating, this.reviews)),
      ]));
    }
  }
}
