//Post Class

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:istishara/Services/Database/database.dart';

class Post {
  String uid;
  String body;
  String author;
  String type;
  Set usersAnswered = {};
  String createdAt;
  DatabaseReference _id;

  Post(this.body, this.author, this.type, this.uid, this.createdAt);

  void answerPost(User user) {
    if (this.usersAnswered.contains(user.uid)) {
      this.usersAnswered.remove(user.uid);
    } else {
      this.usersAnswered.add(user.uid);
    }
    this.update();
  }

  void update() {
    updatePost(this, this._id);
  }

  void setId(DatabaseReference id) {
    this._id = id;
  }

  Map<String, dynamic> toJson() {
    return {
      'author': this.author,
      'usersAnswered': this.usersAnswered.toList(),
      'body': this.body,
      'type': this.type,
      'uid': this.uid,
      'createdAt': this.createdAt,
    };
  }
}

Post createPost(record) {
  Map<String, dynamic> attributes = {
    'author': '',
    'usersAnswered': [],
    'body': '',
    'type': '',
    'uid': '',
    'createdAt': ''
  };

  record.forEach((key, value) => {attributes[key] = value});

  Post post = new Post(attributes['body'], attributes['author'],
      attributes['type'], attributes['uid'], attributes['createdAt']);
  post.usersAnswered = new Set.from(attributes['usersAnswered']);
  return post;
}
