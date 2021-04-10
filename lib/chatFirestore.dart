import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference chats = FirebaseFirestore.instance.collection('chats');

Future<void> addChat(String chatID) {
  return chats.doc(chatID).set({'createdAt': DateTime.now(), 'messages': []});
}

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
