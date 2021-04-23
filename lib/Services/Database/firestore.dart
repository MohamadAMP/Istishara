//Firestore Services

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:istishara/Services/Database/database.dart';

CollectionReference chats = FirebaseFirestore.instance.collection('chats');
CollectionReference ratings = FirebaseFirestore.instance.collection('ratings');
CollectionReference tokens = FirebaseFirestore.instance.collection('tokens');
CollectionReference chatList =
    FirebaseFirestore.instance.collection('chatList');
CollectionReference messagePile =
    FirebaseFirestore.instance.collection('messagePile');
CollectionReference proData = FirebaseFirestore.instance.collection('proData');

Future<void> addChat(String chatID) {
  return chats.doc(chatID).set({'modifiedAt': DateTime.now(), 'messages': []});
}

Future<void> addOrUpdateProData(String uid, String bio) {
  return proData.doc(uid).set({'bio': bio, 'image': ''});
}

Future<void> updateProData(String uid, String bio) async {
  var doc = await proData.doc(uid).get();

  if (!doc.exists) {
    await proData.doc(uid).set({'bio': bio, 'image': ''});
  }

  var ref = proData.doc(uid);
  return ref.update({'bio': bio});
}

Future<void> addChatList(String uid, String type) {
  return chatList.doc(uid).set({'type': type, 'chats': []});
}

Future<void> updateChatList(String uid, String uidOther) async {
  var temp = [];
  temp.add(uidOther);
  var ref = await chatList.doc(uid);
  ref.update({'chats': FieldValue.arrayUnion(temp)});
  temp = [];
}

Future<void> deleteChat(String chatID) {
  return chats.doc(chatID).delete();
}

// ignore: missing_return
Future<void> sendMessage(
    String chatID, String content, String uid, String sentTo) async {
  var nameFrom = await getNameByUid(uid);
  var nameTo = await getNameByUid(sentTo);
  await messagePile.add({
    'fromUID': uid,
    'fromName': nameFrom,
    'toUID': sentTo,
    'toName': nameTo,
    'content': content
  });
  var data = {
    'content': content,
    'createdAt': DateTime.now(),
    'uidUser': uid,
    'sentTo': sentTo
  };

  var temp = [];
  temp.add(data);
  var ref = chats.doc(chatID);
  ref.update(
      {'modifiedAt': DateTime.now(), 'messages': FieldValue.arrayUnion(temp)});
  temp = [];
}

Future<void> addRating(
  String uidReceiver,
  String uidUser,
  String comment,
  int starsCount,
) async {
  //print('test');
  var doc = await ratings.doc(uidReceiver).get();
  //print(doc);
  if (!(doc.exists)) {
    var data = {
      'comment': comment,
      'stars': starsCount,
      'uid': uidUser,
    };
    var temp = [];
    temp.add(data);
    ratings.doc(uidReceiver).set({'usersRated': []});
    var ref = ratings.doc(uidReceiver);
    ref.update({'usersRated': FieldValue.arrayUnion(temp)});
    temp = [];
  } else {
    var data = {
      'comment': comment,
      'stars': starsCount,
      'uid': uidUser,
    };
    var temp = [];
    temp.add(data);
    var ref = ratings.doc(uidReceiver);
    ref.update({'usersRated': FieldValue.arrayUnion(temp)});
    temp = [];
  }
}

Future<List<dynamic>> getUserRatingByUid(String uid) async {
  var ratingJobsDone = [];
  int stars = 0;
  int jobsDone = 0;
  var doc = await ratings.doc(uid).get();
  if (!doc.exists) {
    return [0.00, 0];
  }
  var data = doc.data().values.toList().elementAt(0);
  data.forEach((rating) async {
    stars += rating['stars'];
    jobsDone += 1;
  });

  ratingJobsDone.add(stars / jobsDone);
  ratingJobsDone.add(jobsDone);
  //print(data);

  return ratingJobsDone;
}

Future<List<dynamic>> getUserReviewsbyUid(String uid) async {
  var reviews = [];
  var doc = await ratings.doc(uid).get();
  if (!doc.exists) {
    return [];
  }
  var data = doc.data().values.toList().elementAt(0);
  data.forEach((rating) async {
    if (rating['comment'] == "") {
    } else {
      var name = await getNameByUid(rating['uid']);
      var temp = [];
      temp.add(name);
      temp.add(rating['stars']);
      temp.add(rating['comment']);
      reviews.add(temp);
      temp = [];
    }
  });
  return reviews;
}

Future<List<dynamic>> getUserChatsbyUid(String uid) async {
  var chats = [];
  var doc = await chatList.doc(uid).get();
  if (!doc.exists) {
    return [];
  }
  var x = doc.data().values.first;
  chats = x;
  //print(chats);

  return chats;
}

saveDeviceToken(String uid) async {
  User user = FirebaseAuth.instance.currentUser;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  String token = await firebaseMessaging.getToken();

  if (token != null) {
    tokens.doc(uid).set({'token': token});
  }
}

Future<List<dynamic>> getUserBioAndImage(String uid) async {
  var bioImage = [];
  var ref = await proData.doc(uid).get();

  //print(ref.data());
  if (ref.exists) {
    bioImage.add(ref.data());
  }
  return bioImage;
}
