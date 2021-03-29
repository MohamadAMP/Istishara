import 'package:flutter/material.dart';

import 'auth.dart';
import 'login.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Messages'), actions: <Widget>[
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
    );
  }
}
