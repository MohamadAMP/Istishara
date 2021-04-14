import 'package:flutter/material.dart';

import 'auth.dart';
import 'login.dart';

class ProfessionalProfile extends StatefulWidget {
  final List<dynamic> userData;

  ProfessionalProfile(this.userData);
  @override
  _ProfessionalProfileState createState() => _ProfessionalProfileState();
}

class _ProfessionalProfileState extends State<ProfessionalProfile> {
  Set<dynamic> userData;
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
      body: Column(children: <Widget>[
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
                                "4.5",
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
                                "7",
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
                      onPressed: () {},
                      icon: Icon(Icons.edit, size: 18),
                      label: Text(
                        "Edit Profile",
                        style: TextStyle(color: Colors.grey[300], fontSize: 16),
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
        )
      ]),
    );
  }
}
