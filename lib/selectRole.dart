import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:istishara/database.dart';
import 'package:istishara/homePages/baseClientHomepage.dart';
import 'package:istishara/professionalRole.dart';
import 'package:istishara/userData.dart';

class RoleSelection extends StatefulWidget {
  final User user;

  RoleSelection(this.user);
  @override
  _RoleSelection createState() => _RoleSelection();
}

class _RoleSelection extends State<RoleSelection> {
  void newProfesional() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => FormScreen(widget.user)));
  }

  void newClient() {
    var user = new UserData(
        widget.user.displayName, widget.user.email, widget.user.uid, 'Client');

    user.setId(addUser(user));
    // getAllUid().then((uids) => {
    //       print(uids),
    //       if (!uids.contains(widget.user.uid)) {user.setId(addUser(user))}
    //     });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BaseClientHomepage(widget.user)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Istishara'),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(height: 15),
            Container(
              alignment: Alignment.center,
              height: 300,
              child: Image(
                image: AssetImage('assets/login.jpeg'),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 35),
            Text(
              "Name: " + widget.user.displayName,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 15),
            Text(
              "Email: " + widget.user.email,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 35),
            Text(
              "Please select your role:",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RaisedButton(
                  padding: EdgeInsets.all(15),
                  onPressed: this.newClient,
                  child: Text('Client'),
                  color: Colors.orange,
                  splashColor: Colors.blue,
                ),
                SizedBox(
                  width: 20,
                ),
                RaisedButton(
                  padding: EdgeInsets.all(15),
                  onPressed: this.newProfesional,
                  child: Text('Professional'),
                  color: Colors.orange,
                  splashColor: Colors.blue,
                ),
              ],
            )
          ],
        ));
  }
}
