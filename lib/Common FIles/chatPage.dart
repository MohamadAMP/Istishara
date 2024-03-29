//Base Chat Page

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:istishara/Client/Chat/displayChatContactsClient.dart';

import '../Professional/Chat/displayChatContactsPro.dart';
import '../Services/Database/database.dart';
import '../Services/Database/firestore.dart';

// ignore: must_be_immutable
class Chat extends StatefulWidget {
  User user;

  Chat(this.user);
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> with TickerProviderStateMixin {
  List<dynamic> chats = [];
  List<dynamic> usersAnswered = [];
  List<dynamic> usersNamesPost = [];
  String name = '';
  List<dynamic> userInfo = [];
  AnimationController controller;
  var link;

  void post(Function callBack) {
    this.setState(() {
      callBack();
    });
  }

  void updateUsers() async {
    await getUserChatsbyUid(widget.user.uid).then((chats) {
      setState(() {
        this.chats = chats;
      });
    });
    //print(this.chats);
    List<dynamic> _usersAnswered = [];
    List<dynamic> _usersNamesPost = [];
    List<dynamic> temp = [];
    await getUsersAnswered(widget.user.uid).then((uidPosts) {
      uidPosts.forEach((uidPost) async => {
            link = await getProfilePic(uidPost[0]),
            if (chats.contains(uidPost[0]))
              {
                //print("true"),
                //_usersAnswered.add(uidPost[0]),
                print(name),
                temp.add(link[0]),
                temp.add(uidPost[1]),
                temp.add(uidPost[0]),
                temp.add(link[1]),
                print(temp),
                _usersNamesPost.add(temp),
                temp = [],
              }
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

  void getChats() async {
    await getUserChatsbyUid(widget.user.uid).then((chats) {
      setState(() {
        this.chats = chats;
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

    super.initState();
    updateUsers();
    getUserInfo();
    getChats();
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
            appBar: AppBar(title: Text('Messages')),
            body: DisplayChatContacts(this.usersNamesPost, this.usersAnswered,
                this.widget.user.uid, this.chats));
      } else {
        return Scaffold(
            appBar: AppBar(title: Text('Messages')),
            body: DisplayChatContactsPro(this.widget.user.uid));
      }
    }
  }
}
