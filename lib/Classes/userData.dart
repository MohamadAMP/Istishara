//User Data Class

import 'package:firebase_database/firebase_database.dart';

class UserData {
  String name;
  String email;
  String uid;
  String role;
  DatabaseReference _id;

  UserData(this.name, this.email, this.uid, this.role);

  void setId(DatabaseReference id) {
    this._id = id;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'email': this.email,
      'uid': this.uid,
      'role': this.role
    };
  }
}

UserData createUser(record) {
  Map<String, dynamic> attributes = {
    'name': '',
    'email': '',
    'uid': '',
    'role': ''
  };

  record.forEach((key, value) => {attributes[key] = value});

  UserData user = new UserData(attributes['name'], attributes['email'],
      attributes['uid'], attributes['role']);
  return user;
}
