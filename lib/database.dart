import 'package:firebase_database/firebase_database.dart';
import 'post.dart';
import 'userData.dart';

final databaseReference = FirebaseDatabase.instance.reference();

DatabaseReference savePost(Post post) {
  var id = databaseReference.child('/posts').push();
  id.set(post.toJson());
  return id;
}

DatabaseReference addUser(UserData user) {
  var id = databaseReference.child('/users').push();
  id.set(user.toJson());
  return id;
}

void updatePost(Post post, DatabaseReference id) {
  id.update(post.toJson());
}

Future<List<Post>> getAllPosts() async {
  DataSnapshot dataSnapshot = await databaseReference.child('posts/').once();
  List<Post> posts = [];

  if (dataSnapshot.value != null) {
    dataSnapshot.value.forEach((key, value) {
      Post post = createPost(value);
      post.setId(databaseReference.child('posts/' + key));
      posts.add(post);
    });
  }

  return posts;
}

Future<Set> getAllUid() async {
  DataSnapshot dataSnapshot = await databaseReference.child('users/').once();

  Set uids = {};

  if (dataSnapshot.value != null) {
    dataSnapshot.value.forEach((uid, value) {
      String uid = value;
      uids.add(uid);
    });
  }

  return uids;
}

Future<Set> getAllUsers() async {
  DataSnapshot dataSnapshot = await databaseReference.child('users/').once();

  Set users = {};

  if (dataSnapshot.value != null) {
    dataSnapshot.value.forEach((key, value) {
      UserData user = createUser(value);
      user.setId(databaseReference.child('users/' + key));
      users.add(user);
    });
  }

  return users;
}

Future<String> getNameByUid(String uid) async {
  final dbRef = FirebaseDatabase.instance.reference();
  DataSnapshot snapshot;
  Map<dynamic, dynamic> values;
  String key;
  String name;

  snapshot =
      await dbRef.child('users/').orderByChild('uid').equalTo(uid).once();
  if (snapshot.value != null) {
    values = snapshot.value;
    key = values.keys.first;
    name = values[key]['name'];
    print(values[key]['name']);
  }

  return name;
}

Future<List<dynamic>> getUserDataByUid(String uid) async {
  List<dynamic> userData = [];
  final dbRef = FirebaseDatabase.instance.reference();
  DataSnapshot snapshot;
  Map<dynamic, dynamic> values;
  String key;

  snapshot =
      await dbRef.child('users/').orderByChild('uid').equalTo(uid).once();
  if (snapshot.value != null) {
    values = snapshot.value;
    key = values.keys.first;
    userData.add(values[key]['name']);
    userData.add(values[key]['role']);
    userData.add(values[key]['uid']);
  }
  return userData;
}

Future<List<dynamic>> getUidName(Post post) async {
  List<dynamic> uidName = [];
  final dbRef = FirebaseDatabase.instance.reference();
  DataSnapshot snapshot;
  Map<dynamic, dynamic> values;
  String key;
  post.usersAnswered.toList().forEach((uid) async => {
        snapshot =
            await dbRef.child('users/').orderByChild('uid').equalTo(uid).once(),
        if (snapshot.value != null)
          {
            values = snapshot.value,
            key = values.keys.first,
            uidName.add([values[key]['uid'], values[key]['name']]),
          }
      });
  return uidName;
}

Future<List<dynamic>> getUsersAnswered(String uid) async {
  List<dynamic> usersAnswered = [];
  List<Post> posts = await getAllPosts();
  List<dynamic> temp = [];
  posts.forEach((post) => {
        if (post.uid == uid)
          {
            print(post.author),
            post.usersAnswered.forEach((uid) => {
                  temp.add(uid),
                  temp.add(post.body),
                  print(temp),
                  usersAnswered.add(temp),
                  temp = [],
                })
          }
      });
  print(usersAnswered);
  return usersAnswered;
}

Future<List<dynamic>> getUsersAnsweredPro(String uid) async {
  List<dynamic> usersAnswered = [];
  List<Post> posts = await getAllPosts();
  List<dynamic> temp = [];

  posts.forEach((post) => {
        if (post.usersAnswered.contains(uid))
          {
            temp.add(post.uid),
            temp.add(post.body),
            usersAnswered.add(temp),
            temp = [],
          }
      });

  return usersAnswered;
}
