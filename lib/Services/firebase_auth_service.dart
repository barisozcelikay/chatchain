import 'package:chatchain/Classes/userr.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseAuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("Users");

  Userr? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return Userr(
        name: "name",
        surname: "surname",
        date_of_birth: "sada",
        email: user.email.toString(),
        uid: user.uid,
        photoUrl: user.photoURL.toString());
  }

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

  Future deleteUser() async {
    try {
      await userCollection.doc(_firebaseAuth.currentUser?.uid).delete();
      await _firebaseAuth.currentUser?.delete();

      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Userr?> getUserData() async {
    Userr? user = null;
    try {
      var profileInfo =
          await userCollection.doc(_firebaseAuth.currentUser?.uid).get();

      String uid = profileInfo["uid"];
      String name = profileInfo["name"];
      String surname = profileInfo["surname"];
      String email = profileInfo["email"];
      String date_of_birth = profileInfo["date_of_birth"];
      String photoUrl = profileInfo["image"];

      var imageName = photoUrl;
      print(imageName);

      final ref = FirebaseStorage.instance
          .ref()
          .child('Users')
          .child(uid)
          .child(imageName);

      var new_url = await ref.getDownloadURL();

      user = Userr(
          uid: uid,
          email: email,
          photoUrl: new_url,
          name: name,
          surname: surname,
          date_of_birth: date_of_birth);

      return user;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Userr?> getFriendData(String userId) async {
    Userr? user = null;
    try {
      var profileInfo = await userCollection.doc(userId).get();

      String uid = profileInfo["uid"];
      String name = profileInfo["name"];
      String surname = profileInfo["surname"];
      String email = profileInfo["email"];
      String date_of_birth = profileInfo["date_of_birth"];
      String photoUrl = profileInfo["image"];

      var imageName = photoUrl;
      print(imageName);

      final ref = FirebaseStorage.instance
          .ref()
          .child('Users')
          .child(uid)
          .child(imageName);

      var new_url = await ref.getDownloadURL();

      user = Userr(
          uid: uid,
          email: email,
          photoUrl: new_url,
          name: name,
          surname: surname,
          date_of_birth: date_of_birth);

      return user;
    } catch (e) {
      print(e.toString());
    }
  }
}
