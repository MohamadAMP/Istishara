//Display Professional Profile (Professional View)

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:istishara/Services/Database/firestore.dart';

import '../../Services/Authentication/auth.dart';
import '../../Services/Login/login.dart';

// ignore: must_be_immutable
class ProfessionalProfile extends StatefulWidget {
  final List<dynamic> userData;
  int jobsDone;
  double rating;
  List<dynamic> reviews;
  List<dynamic> bioImage;
  ProfessionalProfile(
      this.userData, this.jobsDone, this.rating, this.reviews, this.bioImage);
  @override
  _ProfessionalProfileState createState() => _ProfessionalProfileState();
}

class _ProfessionalProfileState extends State<ProfessionalProfile>
    with TickerProviderStateMixin {
  AnimationController controller;
  Set<dynamic> userData;
  final _controller = new TextEditingController();
  var bio;
  var bioDisplay;
  User user = FirebaseAuth.instance.currentUser;

  var url = FirebaseAuth.instance.currentUser.photoURL;
  void click() {
    if (bio != null) {
      addOrUpdateProData(user.uid, bio);
      _controller.clear();
      setState(() {
        widget.bioImage[0] = bio;
      });
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text('Edit About Me'),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SizedBox(height: 20),
                TextField(
                  controller: this._controller,
                  decoration: InputDecoration(hintText: ""),
                  maxLines: 2,
                  onChanged: (value) {
                    setState(() {
                      bio = value;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                this.click();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);

    this.userData = widget.userData.toSet();
  }

  @override
  Widget build(BuildContext context) {
    var pic = Image.network(this.url, height: 120, width: 120);
    this.userData = this.widget.userData.toSet();
    if (widget.rating == null) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Profile"),
          ),
          body: Center(
              child: CircularProgressIndicator(
            value: controller.value,
          )));
    } else {
      if (widget.reviews.isNotEmpty) {
        return Scaffold(
            appBar: AppBar(title: Text('Profile'), actions: <Widget>[
              Row(
                children: <Widget>[
                  Container(child: Text('Log out')),
                  IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () async {
                      signOut();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                  )
                ],
              ),
            ]),
            body: SingleChildScrollView(
              child: Column(children: <Widget>[
                Container(
                  color: Colors.orange[400],
                  height: 230,
                  child: Padding(
                    padding: EdgeInsets.only(left: 0.0, right: 30.0, top: 30.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 40, 0),
                              child: Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: pic.image != null
                                            ? pic.image
                                            : Icon(Icons.account_circle,
                                                size: 120))),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  (this.userData.length > 0
                                          ? this.userData.elementAt(0)
                                          : '') +
                                      '\n' +
                                      (this.userData.length > 0
                                          ? this.userData.elementAt(1)
                                          : ''),

                                  //you might have to add another text widget depending on how you retrieve it
                                  overflow: TextOverflow.visible,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(11.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Rating",
                                        style: TextStyle(
                                            //add rating in the future
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        this.widget.rating.isNaN
                                            ? '0.00'
                                            : this
                                                .widget
                                                .rating
                                                .toStringAsFixed(2),
                                        style: TextStyle(
                                            //add rating in the future
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(11.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Jobs Done",
                                        style: TextStyle(
                                            //add the number of questions answered in the future
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        this.widget.jobsDone.toString(),
                                        style: TextStyle(
                                            //add the number of questions answered in the future
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            // ignore: deprecated_member_use
                            OutlineButton.icon(
                              onPressed: () {
                                _showMyDialog();
                              },
                              icon: Icon(Icons.edit, size: 18),
                              label: Text(
                                "Edit Profile",
                                style: TextStyle(
                                    color: Colors.grey[300], fontSize: 16),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 32.0, right: 32.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "About Me",
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        this.widget.bioImage.isNotEmpty
                            ? this.widget.bioImage[0]
                            : "You have not entered your bio yet",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 32.0, right: 32.0),
                    child: Center(
                        child: Text(
                      "Reviews:",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ))),
                Container(
                    height: 237,
                    child: ListView.builder(
                      itemCount: this.widget.reviews.length,
                      // ignore: missing_return
                      itemBuilder: (context, index) {
                        var review = this.widget.reviews[index];
                        if (review[2] != "") {
                          return Card(
                            shape: new RoundedRectangleBorder(
                                side: new BorderSide(
                                    color: Colors.grey[400], width: 2.0),
                                borderRadius: BorderRadius.circular(4.0)),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: ListTile(
                                  title: Text(review[2].toString()),
                                  subtitle: Text(review[0].toString() +
                                      " - Rating: " +
                                      review[1].toString() +
                                      "/5"),
                                )),
                              ],
                            ),
                          );
                        } else {
                          return SizedBox(
                            height: 0,
                          );
                        }
                      },
                    ))
              ]),
            ));
      } else {
        return Scaffold(
            appBar: AppBar(title: Text('Profile'), actions: <Widget>[
              Row(
                children: <Widget>[
                  Container(child: Text('Log out')),
                  IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () async {
                      signOut();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                  )
                ],
              ),
            ]),
            body: SingleChildScrollView(
              child: Column(children: <Widget>[
                Container(
                  color: Colors.orange[400],
                  height: 230,
                  child: Padding(
                    padding: EdgeInsets.only(left: 0.0, right: 30.0, top: 30.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 40, 0),
                              child: Container(
                                height: 120,
                                width: 120,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: pic.image != null
                                            ? pic.image
                                            : Icon(Icons.account_circle,
                                                size: 120))),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  (this.userData.length > 0
                                          ? this.userData.elementAt(0)
                                          : '') +
                                      '\n' +
                                      (this.userData.length > 0
                                          ? this.userData.elementAt(1)
                                          : ''),

                                  //you might have to add another text widget depending on how you retrieve it
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(11.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Rating",
                                        style: TextStyle(
                                            //add rating in the future
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        this.widget.rating.isNaN
                                            ? '0.00'
                                            : this
                                                .widget
                                                .rating
                                                .toStringAsFixed(2),
                                        style: TextStyle(
                                            //add rating in the future
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(11.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Jobs Done",
                                        style: TextStyle(
                                            //add the number of questions answered in the future
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        this.widget.jobsDone.toString(),
                                        style: TextStyle(
                                            //add the number of questions answered in the future
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            // ignore: deprecated_member_use
                            OutlineButton.icon(
                              onPressed: () {
                                _showMyDialog();
                              },
                              icon: Icon(Icons.edit, size: 18),
                              label: Text(
                                "Edit Profile",
                                style: TextStyle(
                                    color: Colors.grey[300], fontSize: 16),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 32.0, right: 32.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "About Me",
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        this.widget.bioImage.isNotEmpty
                            ? this.widget.bioImage[0]
                            : "You have not entered your bio yet",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 32.0, right: 32.0),
                    child: Center(
                        child: Text(
                      "Reviews:",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ))),
                Container(
                    height: 80,
                    child: Card(
                      shape: new RoundedRectangleBorder(
                          side: new BorderSide(
                              color: Colors.grey[400], width: 2.0),
                          borderRadius: BorderRadius.circular(4.0)),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: ListTile(
                            title: Text("There are no reviews yet."),
                          )),
                        ],
                      ),
                    ))
              ]),
            ));
      }
    }
  }
}
