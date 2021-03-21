import 'package:istishara/chatPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:istishara/categorySelection.dart';
import 'package:flutter/material.dart';
import 'package:istishara/clientQuestions.dart';

class BaseClientHomepage extends StatefulWidget {
  final User user;
  BaseClientHomepage(this.user);

  @override
  _BaseClientHomepageState createState() => _BaseClientHomepageState();
}

class _BaseClientHomepageState extends State<BaseClientHomepage> {
  int _selectedIndex = 0;

  PageController _pageController = PageController();

  void _onPageChanged(int index) {
    setState(() {
      {
        _selectedIndex = index;
      }
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          CategorySelection(widget.user),
          Chat(),
          ClientQuestions(widget.user)
        ],
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded,
                  color: _selectedIndex == 0 ? Colors.grey : null),
              // ignore: deprecated_member_use
              title: Text('Home',
                  style: TextStyle(
                      color: _selectedIndex == 0 ? Colors.grey : null)),
              backgroundColor: Colors.orange),
          BottomNavigationBarItem(
              icon: Icon(Icons.question_answer_rounded,
                  color: _selectedIndex == 1 ? Colors.grey : null),
              // ignore: deprecated_member_use
              title: Text('Messaging',
                  style: TextStyle(
                      color: _selectedIndex == 1 ? Colors.grey : null)),
              backgroundColor: Colors.orange),
          BottomNavigationBarItem(
              icon: Icon(Icons.help_outline_rounded,
                  color: _selectedIndex == 2 ? Colors.grey : null),
              // ignore: deprecated_member_use
              title: Text(
                'Questions',
                style:
                    TextStyle(color: _selectedIndex == 2 ? Colors.grey : null),
              ),
              backgroundColor: Colors.orange),
          //BottomNavigationBarItem(icon:Icon(Icons.power_settings_new_rounded),label:'Log Out',backgroundColor: Colors.orange),
        ],
      ),
    );
  }
}