import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class MiagedFirebaseUser {
  MiagedFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

MiagedFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<MiagedFirebaseUser> miagedFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<MiagedFirebaseUser>((user) => currentUser = MiagedFirebaseUser(user));
