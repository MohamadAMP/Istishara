//Professional Chooses Role

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:istishara/Professional/baseProfessionalHomepage.dart';
import 'package:istishara/Services/Database/firestore.dart';
import '../Database/database.dart';
import '../../Classes/userData.dart';

class FormScreen extends StatefulWidget {
  final User user;

  FormScreen(this.user);

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  String _fieldofWork; //dropdownvalue
  String _fieldofStudy;
  String _phone;
  String _url;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void submit() {
    var user = new UserData(widget.user.displayName, widget.user.email,
        widget.user.uid, _fieldofWork);

    user.setId(addUser(user));
    
    saveDeviceToken(user.uid);
    
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                BaseProfessionalHomepage(widget.user, user.role)));
  }

  Widget _buildWork() {
    return DropdownButton<String>(
      hint: Text("Work Field"),
      value: _fieldofWork,
      icon: Icon(
        Icons.import_export_sharp,
      ),
      iconSize: 16,
      itemHeight: 70,
      elevation: 8,
      onChanged: (String newValue) {
        setState(() {
          _fieldofWork = newValue;
        });
      },
      items: <String>[
        'Architecture',
        'Interior Design',
        'Civil Engineering',
        'Mechancal Engineering',
        'Electrical & Communications Engineering'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _buildStudyfield() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Field of Study"),
      // ignore: missing_return
      validator: (String value) {
        if (value.isEmpty) {
          return "Field of Study Required";
        }
      },
      onSaved: (String value) {
        _fieldofStudy = value;
      },
    );
  }

  Widget _buildphonefield() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Phone number'),
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone number is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _url = value;
      },
    );
  }

  Widget _buildURLfield() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'LinkedIn or Portfolio URL'),
      keyboardType: TextInputType.url,
      onSaved: (String value) {
        _url = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Center(child: Text("Complete Professional Profile"))),
        body: Container(
            margin: EdgeInsets.all(24),
            child: Form(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  _buildWork(),

                  SizedBox(height: 35),
                  // ignore: deprecated_member_use
                  RaisedButton(
                    child: Text("Submit"),
                    color: Colors.orange,
                    splashColor: Colors.blue,
                    onPressed: this.submit,
                  )
                ]))));
  }
}
