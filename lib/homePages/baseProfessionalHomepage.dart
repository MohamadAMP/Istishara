import 'package:istishara/chatPage.dart';
import 'package:istishara/professionalProfile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:istishara/homePages/homePageProfessional.dart';

import '../professionalProfileHelp.dart';

// ignore: must_be_immutable
class BaseProfessionalHomepage extends StatefulWidget {
  String type;
  final User user;
  BaseProfessionalHomepage(this.user, this.type);
  @override
  _BaseProfHomepageState createState() => _BaseProfHomepageState();
}

class _BaseProfHomepageState extends State<BaseProfessionalHomepage> {
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
          MyHomePagePro(widget.user, widget.type),
          Chat(),
          ProfessionalProfileHelp(widget.user.uid)
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
              icon: Icon(Icons.person,
                  color: _selectedIndex == 2 ? Colors.grey : null),
              // ignore: deprecated_member_use
              title: Text('Profile',
                  style: TextStyle(
                      color: _selectedIndex == 2 ? Colors.grey : null)),
              backgroundColor: Colors.orange),
          //BottomNavigationBarItem(icon:Icon(Icons.power_settings_new_rounded),label:'Log Out',backgroundColor: Colors.orange),
        ],
      ),
    );
  }
}
