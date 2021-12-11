import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class Walmart1585OPDFirebaseUser {
  Walmart1585OPDFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

Walmart1585OPDFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<Walmart1585OPDFirebaseUser> walmart1585OPDFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<Walmart1585OPDFirebaseUser>(
            (user) => currentUser = Walmart1585OPDFirebaseUser(user));
