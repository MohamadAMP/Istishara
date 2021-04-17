//Base Chat Page

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:istishara/Client/Chat/displayChatContactsClient.dart';

import '../Services/Authentication/auth.dart';
import '../Professional/Chat/displayChatContactsPro.dart';
import '../Services/Login/login.dart';
import '../Services/Database/database.dart';

// ignore: must_be_immutable
class Chat extends StatefulWidget {
  User user;

  Chat(this.user);
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> with TickerProviderStateMixin {
  List<dynamic> usersAnswered = [];
  List<dynamic> usersNamesPost = [];
  String name = '';
  List<dynamic> userInfo = [];
  AnimationController controller;

  void post(Function callBack) {
    this.setState(() {
      callBack();
    });
  }

  void updateUsers() async {
    List<dynamic> _usersAnswered = [];
    List<dynamic> _usersNamesPost = [];
    List<dynamic> temp = [];
    await getUsersAnswered(widget.user.uid).then((uidPosts) {
      uidPosts.forEach((uidPost) async => {
            _usersAnswered.add(uidPost[0]),
            name = await getNameByUid(uidPost[0]),
            temp.add(name),
            temp.add(uidPost[1]),
            _usersNamesPost.add(temp),
            temp = [],
          });
      setState(() {
        this.usersAnswered = _usersAnswered;
        this.usersNamesPost = _usersNamesPost;
      });
    });
  }

  void getUserInfo() async {
    await getUserDataByUid(widget.user.uid).then((data) {
      setState(() {
        this.userInfo = data;
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
    controller.repeat(max: 1);
    controller.forward();
    super.initState();
    updateUsers();
    getUserInfo();
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (userInfo.isEmpty) {
      return Center(
          child: CircularProgressIndicator(
        value: controller.value,
      ));
    } else {
      if (this.userInfo[1] == 'Client') {
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
            body: DisplayChatContacts(
                this.usersNamesPost, this.usersAnswered, this.widget.user.uid));
      } else {
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
            body: DisplayChatContactsPro(this.widget.user.uid));
      }
    }
  }
}
