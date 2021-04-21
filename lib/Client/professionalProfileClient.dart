//Display Advisor Profile Page (Client View)

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:istishara/Services/Database/firestore.dart';
import 'package:rating_dialog/rating_dialog.dart';

// ignore: must_be_immutable
class ProfessionalProfileClient extends StatefulWidget {
  final List<dynamic> userData;
  int jobsDone;
  double rating;
  List<dynamic> reviews;
  ProfessionalProfileClient(
      this.userData, this.jobsDone, this.rating, this.reviews);
  @override
  _ProfessionalProfileClientState createState() =>
      _ProfessionalProfileClientState();
}

class _ProfessionalProfileClientState extends State<ProfessionalProfileClient> {
  Set<dynamic> userData;

  void _showRatingDialog() {
    final _dialog = RatingDialog(
      // your app's name?
      title: 'Istishara',
      // encourage your user to leave a high rating?
      message: 'Tap a star to set your rating.',
      // your app's logo?
      image: Image.asset("assets/istisharaphoto.jpeg"),
      submitButton: 'Submit',
      onSubmitted: (response) {
        addRating(
          this.userData.elementAt(2),
          FirebaseAuth.instance.currentUser.uid,
          response.comment,
          response.rating,
        );
        var temp = [
          FirebaseAuth.instance.currentUser.displayName,
          response.rating,
          response.comment
        ];
        this.widget.reviews.add(temp);
        temp = [];
        setState(() {});
        //print('rating: ${response.rating}, comment: ${response.comment}');
      },
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) => _dialog,
    );
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    this.userData = widget.userData.toSet();
  }

  @override
  Widget build(BuildContext context) {
    this.userData = this.widget.userData.toSet();
    if (widget.reviews.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Profile')),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Container(
            color: Colors.orange[400],
            height: 260,
            child: Padding(
              padding: EdgeInsets.only(left: 0.0, right: 30.0, top: 30.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 200,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/login.jpeg"))),
                      ),
                      SizedBox(
                        width: 5,
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
                    height: 30,
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
                                      : this.widget.rating.toStringAsFixed(2),
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
                        padding: EdgeInsets.all(10),
                        borderSide: BorderSide(color: Colors.white),
                        onPressed: () {
                          _showRatingDialog();
                        },
                        icon: Icon(Icons.star, size: 18, color: Colors.white),
                        label: Text(
                          "Rate",
                          style: TextStyle(color: Colors.white, fontSize: 16),
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
                  "This is a bunch of text that you should not worry about right now.",
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
          SizedBox(height: 10),
          Container(
              height: 237,
              child: ListView.builder(
                  itemCount: this.widget.reviews.length,
                  // ignore: missing_return
                  itemBuilder: (context, index) {
                    var review = this.widget.reviews[index];

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
                  })),
        ])),
      );
    } else {
      return Scaffold(
        appBar: AppBar(title: Text('Profile')),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Container(
            color: Colors.orange[400],
            height: 260,
            child: Padding(
              padding: EdgeInsets.only(left: 0.0, right: 30.0, top: 30.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 200,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/login.jpeg"))),
                      ),
                      SizedBox(
                        width: 5,
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
                    height: 30,
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
                                  '0.00',
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
                        padding: EdgeInsets.all(10),
                        borderSide: BorderSide(color: Colors.white),
                        onPressed: () {
                          _showRatingDialog();
                        },
                        icon: Icon(Icons.star, size: 18, color: Colors.white),
                        label: Text(
                          "Rate",
                          style: TextStyle(color: Colors.white, fontSize: 16),
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
                  "This is a bunch of text that you should not worry about right now.",
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
          SizedBox(height: 10),
          Container(
              height: 80,
              child: Card(
                shape: new RoundedRectangleBorder(
                    side: new BorderSide(color: Colors.grey[400], width: 2.0),
                    borderRadius: BorderRadius.circular(4.0)),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: ListTile(
                      title: Text("There are no reviews yet."),
                    )),
                  ],
                ),
              )),
        ])),
      );
    }
  }
}
