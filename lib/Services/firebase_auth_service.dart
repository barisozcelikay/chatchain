import 'package:chatchain/Classes/userr.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class FirebaseAuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  Userr? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return Userr(
        displayName: user.displayName.toString(),
        email: user.email.toString(),
        uid: user.uid,
        photoUrl: user.photoURL.toString());
  }

//?
  Stream<Userr?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<Userr?> signInWithEmailAndPassword(
      String email, String password) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(credential.user);
  }

  Future<Userr?> createUserWithEmailAndPassword(
      String email, String password) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(credential.user);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
