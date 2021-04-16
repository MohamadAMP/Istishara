import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:istishara/database.dart';

CollectionReference chats = FirebaseFirestore.instance.collection('chats');
CollectionReference ratings = FirebaseFirestore.instance.collection('ratings');

Future<void> addChat(String chatID) {
  return chats.doc(chatID).set({'createdAt': DateTime.now(), 'messages': []});
}

// ignore: missing_return
Future<void> sendMessage(String chatID, String content, String uid) {
  var data = {
    'content': content,
    'createdAt': DateTime.now(),
    'uid': uid,
  };
  var temp = [];
  temp.add(data);
  var ref = chats.doc(chatID);
  ref.update({'messages': FieldValue.arrayUnion(temp)});
  temp = [];
}

Future<void> addRating(
  String uidReceiver,
  String uidUser,
  String comment,
  int starsCount,
) async {
  print('test');
  var doc = await ratings.doc(uidReceiver).get();
  print(doc);
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
  print(data);

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
