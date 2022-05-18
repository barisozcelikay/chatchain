import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_auth/firebase_auth.dart' as auth;

class Storage {
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;

  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  Future<void> uploadFile(String filePath, String fileName) async {
    File file = File(filePath);

    try {
      await _storage
          .ref('Users/${_firebaseAuth.currentUser?.uid}/$fileName')
          .putFile(file);
    } on firebase_core.FirebaseException catch (e) {}
  }

  loadImage() async {
    //current user id
    final _userID = _firebaseAuth.currentUser?.uid;

    //collect the image name
    DocumentSnapshot variable =
        await FirebaseFirestore.instance.collection('Users').doc(_userID).get();

    //a list of images names (i need only one)
    var _file_name = variable['image'];

    //select the image url
    firebase_storage.Reference ref =
        _storage.ref().child("Users/$_userID").child(_file_name[0]);

    //get image url from firebase storage
    var url = await ref.getDownloadURL();

    // put the URL in the state, so that the UI gets rerendered
  }
}
