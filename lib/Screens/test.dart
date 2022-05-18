import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  var url = null;

  Future getImageUrl(String uid) async {
    DocumentSnapshot variable =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();

    var imageName = variable['image'];

    final ref = FirebaseStorage.instance
        .ref()
        .child('Users')
        .child(uid)
        .child(imageName);

    var new_url = await ref.getDownloadURL();
    setState(() {
      setState(() {
        url = new_url;
      });
    });
    return url;
  }

  Future uploadFile(String filePath, String fileName) async {
    File file = File(filePath);

    try {
      await FirebaseStorage.instance
          .ref('Users/ma4ajILLGfP2VuGymg6SwnStVni1/carousel-bose.png')
          .putFile(file);
    } on firebase_core.FirebaseException catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        url != null
            ? CircleAvatar(
                minRadius: 50,
                backgroundImage: NetworkImage(url),
              )
            : CircleAvatar(maxRadius: 80, child: Icon(Icons.add)),
        ElevatedButton(
            onPressed: () async {
              var path;
              var fileName;
              final results = FilePicker.platform.pickFiles(
                  allowMultiple: false,
                  type: FileType.custom,
                  allowedExtensions: ['png', 'jpg']).then(
                (value) {
                  setState(() {
                    path = value?.files.single.path;
                    fileName = value?.files.single.name;
                  });

                  uploadFile(path, fileName).then((value) => print("Done"));
                },
              );
            },
            child: Text("Press"))
      ],
    );
  }
}
