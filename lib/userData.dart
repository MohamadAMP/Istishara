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
