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
  List<dynamic> bioImage = [];
  AnimationController controller;
  var link;

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

  Future<void> getPhotoUrl() async {
    await getProfilePic(widget.uid).then((link) {
      setState(() {
        // print(uid);
        // print(link);
        this.link = link[1];
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

  Future<void> getUserData() async {
    await getUserBioAndImage(widget.uid).then((value) {
      if (value.isNotEmpty) {
        setState(() {
          this.bioImage.add(value[0]['bio']);
          this.bioImage.add(value[0]['image']);
          //print(this.bioImage);
        });
      }
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
    super.initState();
    updateUserData();
    getUserRating();
    getUserReviews();
    getPhotoUrl();
    this.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    if (this.link == null) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Profile"),
          ),
          body: Center(
              child: CircularProgressIndicator(
            value: controller.value,
          )));
    } else {
      if (this.currentUserData.elementAt(1) == 'Client') {
        return Scaffold(
            body: Column(children: <Widget>[
          Expanded(
              child: ProfessionalProfileClient(this.userData, this.jobsDone,
                  this.rating, this.reviews, this.bioImage, this.link)),
        ]));
      } else {
        return Scaffold(
            body: Column(children: <Widget>[
          Expanded(
              child: ProfessionalProfile(this.userData, this.jobsDone,
                  this.rating, this.reviews, this.bioImage)),
        ]));
      }
    }
  }
}
