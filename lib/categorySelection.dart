import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:istishara/homePages/questionsCivil.dart';
import 'package:istishara/homePages/questionsECE.dart';
import 'package:istishara/homePages/questionsID.dart';
import 'package:istishara/homePages/questionsMech.dart';

import 'auth.dart';
import 'homePages/questionsArchitecture.dart';
import 'login.dart';

class CategorySelection extends StatefulWidget {
  final User user;

  CategorySelection(this.user);

  @override
  _CategorySelection createState() => _CategorySelection();
}

class _CategorySelection extends State<CategorySelection> {
  void architecture(String category) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QuestionsArchitecture(widget.user)));
  }

  void interiorDesign(String category) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => QuestionsID(widget.user)));
  }

  void civil(String category) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => QuestionsCivil(widget.user)));
  }

  void mechanical(String category) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => QuestionsMech(widget.user)));
  }

  void ece(String category) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => QuestionsECE(widget.user)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Home'), actions: <Widget>[
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
        body: ListView(children: <Widget>[
          Column(children: <Widget>[
            SizedBox(height: 35),
            Container(
              width: 350,
              padding: EdgeInsets.all(10),
              child: OutlineButton(
                onPressed: () => this.architecture('Architecture'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                splashColor: Colors.grey[600],
                borderSide: BorderSide(color: Colors.grey),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      //Image(
                      //  image: AssetImage('assets/blank_page.png'),
                      //height: 35),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Architecture',
                          style: TextStyle(color: Colors.grey, fontSize: 25),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 35),
            Container(
              width: 350,
              padding: EdgeInsets.all(10),
              child: OutlineButton(
                onPressed: () => this.interiorDesign('Interior Design'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                splashColor: Colors.grey[600],
                borderSide: BorderSide(color: Colors.grey),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      //Image(
                      //  image: AssetImage('assets/blank_page.png'),
                      //height: 35),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Interior Design',
                          style: TextStyle(color: Colors.grey, fontSize: 25),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 35),
            Container(
              width: 350,
              padding: EdgeInsets.all(10),
              child: OutlineButton(
                onPressed: () => this.civil('Civil Engineering'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                splashColor: Colors.grey[600],
                borderSide: BorderSide(color: Colors.grey),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      //Image(
                      //  image: AssetImage('assets/blank_page.png'),
                      //height: 35),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Civil Engineering',
                          style: TextStyle(color: Colors.grey, fontSize: 25),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 35),
            Container(
              width: 350,
              padding: EdgeInsets.all(10),
              child: OutlineButton(
                onPressed: () => this.mechanical('Mechanical Engineering'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                splashColor: Colors.grey[600],
                borderSide: BorderSide(color: Colors.grey),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      //Image(
                      //  image: AssetImage('assets/blank_page.png'),
                      //height: 35),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Mechanical Engineering',
                          style: TextStyle(color: Colors.grey, fontSize: 25),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 35),
            Container(
              width: 350,
              height: 100,
              padding: EdgeInsets.all(10),
              child: OutlineButton(
                onPressed: () =>
                    this.ece('Electrical & Communications Engineering'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                splashColor: Colors.grey[600],
                borderSide: BorderSide(color: Colors.grey),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      //Image(
                      //  image: AssetImage('assets/blank_page.png'),
                      //height: 35),
                      Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Center(
                                child: Text(
                                    'Electrical &\nCommunications Engineering',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 21,
                                    ))),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ])
        ]));
  }
}
