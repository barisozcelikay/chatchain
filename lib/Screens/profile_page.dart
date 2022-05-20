// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chatchain/Classes/userr.dart';
import 'package:chatchain/Screens/profile_qr_page.dart';
import 'package:chatchain/Services/firebase_auth_service.dart';
import 'package:chatchain/Services/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProfilePage extends StatefulWidget {
  static String id = "profile_screen";
  static File? _image;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool editMenu = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String name = "Loading";
  String surname = "Loading";
  String email = "Loading";
  String date_of_birth = "Loading";
  String uid = "";
  static String url = "";
  late File _image;
  selectImageFromGallery() async {
    final picker = ImagePicker();

    final imageFile = await picker.getImage(source: ImageSource.gallery);
    if (imageFile != null) {
      _image = File(imageFile.path);
    }
  }

  @override
  void initState() {
    getData();

    //loadImage();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<File?> getPhoto(bool isCamera) async {
    final XFile? image;
    if (isCamera) {
      image = await ImagePicker().pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
    }

    final File? file = File(image!.path);
    return file;
  }

  getData() async {
    print("Girdi");
    Userr? user = await FirebaseAuthService().getUserData();
    if (user != null) {
      setState(() {
        name = user.name;
        surname = user.surname;
        date_of_birth = user.date_of_birth;
        email = user.email;
        uid = user.uid;
      });
    }

    getImageUrl(uid);
  }

  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  Future getImageUrl(String uid) async {
    DocumentSnapshot variable =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();

    var imageName = variable['image'];
    print(imageName);

    final ref = FirebaseStorage.instance
        .ref()
        .child('Users')
        .child(uid)
        .child(imageName);

    var new_url = await ref.getDownloadURL();

    Userr.sphotoUrl = new_url;

    url = new_url;
    return url;
  }

  Future uploadFile(String filePath, String fileName) async {
    File file = File(filePath);
    print(Userr.sUid);
    try {
      await FirebaseStorage.instance
          .ref('Users/${Userr.sUid}/$fileName')
          .putFile(file);
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(Userr.sUid)
          .update({'image': fileName});
      setState(() {
        Userr.sphotoUrl = fileName;
      });
    } on firebase_core.FirebaseException catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: false,
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: Stack(children: [
                          // ignore: unnecessary_null_compxarison
                          url != null
                              ? CircleAvatar(
                                  radius: 100.0,
                                  backgroundImage: NetworkImage(url),
                                  /*: FileImage(ProfilePage._image!)
                                    as ImageProvider,*/
                                  backgroundColor: Colors.transparent,
                                )
                              : CircleAvatar(
                                  radius: 100.0,
                                  backgroundColor: Colors.red,
                                  backgroundImage: AssetImage(
                                      'assets/images/no-profile.png'),
                                ),
                          Positioned(
                            bottom: 0,
                            right: 20,
                            child: InkWell(
                              onTap: () {
                                /*ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);*/
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ListTile(
                                              leading:
                                                  Text("Photo Select Method"),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                //ProfilePage.camera = true;
                                                File? file =
                                                    await getPhoto(true);
                                                ProfilePage._image = file;
                                                setState(() {});
                                              },
                                              child: ListTile(
                                                leading:
                                                    Icon(Icons.camera_enhance),
                                                title: Text("Take photos"),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                // ProfilePage.file = true;
                                                var path;
                                                var fileName;
                                                final results = FilePicker
                                                    .platform
                                                    .pickFiles(
                                                        allowMultiple: false,
                                                        type: FileType.custom,
                                                        allowedExtensions: [
                                                      'png',
                                                      'jpg'
                                                    ]).then(
                                                  (value) {
                                                    setState(() {
                                                      path = value
                                                          ?.files.single.path;
                                                      fileName = value
                                                          ?.files.single.name;
                                                    });

                                                    uploadFile(path, fileName)
                                                        .then((value) =>
                                                            print("Done"));

                                                    setState(() {});
                                                  },
                                                );

                                                await getImageUrl(uid);

                                                // ÇALIŞIYOR
                                                /*
                                                File? file =
                                                    await getPhoto(false);
                                                ProfilePage._image = file;
                                                */
                                                setState(() {});
                                              },
                                              child: ListTile(
                                                title: Text("Choose photo"),
                                                leading: Icon(Icons.folder),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                ProfilePage._image = null;
                                                setState(() {});
                                              },
                                              child: ListTile(
                                                leading: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                                title: Text(
                                                  "Remove photo",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                child: Icon(Icons.edit),
                              ),
                            ),
                          ),
                          /*Positioned(
                              child: Column(
                            children: [
                              TextButton(
                                  onPressed: () {}, child: Text("Take a photo")),
                                  TextButton(
                                  onPressed: () {}, child: Text("Choose a photo"))
                            ],
                          ))*/
                        ]),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () =>
                              Navigator.pushNamed(context, ProfileQrPage.id),
                          child: Container(
                            constraints: BoxConstraints(
                              minWidth: 30,
                              maxWidth: 120,
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(border: Border.all()),
                            padding: EdgeInsets.all(10),
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Show Qr"),
                                  Icon(Icons.qr_code)
                                ]),
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.people),
                        title: Text("User Informations"),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  Text(
                                    "Name : ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(Userr.sname)
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  Text(
                                    "Surname : ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(Userr.ssurname)
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  Text(
                                    "E-mail : ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(Userr.semail)
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  Text(
                                    "Birthday : ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(Userr.sdate_of_birth)
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
