// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chatchain/Classes/userr.dart';
import 'package:chatchain/Screens/profile_qr_page.dart';
import 'package:chatchain/Services/firebase_auth_service.dart';
import 'package:chatchain/Services/storage.dart';
import 'package:chatchain/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

class ProfilePage extends StatefulWidget {
  static String id = "profile_screen";
  static File? image;

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
  String photo_url = "";
  static String url = "";
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        ProfilePage.image = _image;
        uploadFile2();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        ProfilePage.image = _image;
        uploadFile2();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile2() async {
    if (_image == null) return;
    final fileName = basename(_image!.path);
    final destination = 'Users/${Userr.sUid}';

    try {
      var a = await FirebaseFirestore.instance
          .collection('Users')
          .doc(Userr.sUid)
          .get();

      String old_file_name = a.get('image');
      print(old_file_name);

      // DELETE OLD
      final old_ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child(old_file_name);
      await old_ref.delete();

      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('$fileName');
      // ADD NEW
      await ref.putFile(_image!);

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(Userr.sUid)
          .update({'image': fileName});
    } catch (e) {
      print('error occured');
    }
  }
/*
  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile!.path);
    });
  }

   Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_image.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
        );
  }
  */

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
        photo_url = user.photoUrl;
      });
    }
    if (Userr.sphotoUrl != photo_url) {
      Userr.sphotoUrl = photo_url;
    } else {
      print("Updatelemedi");
    }

    //getImageUrl(uid);
  }

  updateUrl() async {
    Userr? user = await FirebaseAuthService().getUserData();
    if (user != null) {
      setState(() {
        name = user.name;
        surname = user.surname;
        date_of_birth = user.date_of_birth;
        email = user.email;
        uid = user.uid;
        photo_url = user.photoUrl;
      });
    }

    Userr.sphotoUrl = photo_url;
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
    print("Geldi mi");
    print(Userr.sUid);
    try {
      await FirebaseStorage.instance
          .ref('Users/${Userr.sUid}')
          .child('$fileName')
          .putFile(file);

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(Userr.sUid)
          .update({'image': fileName});

      var a = getImageUrl(uid);

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .update({'network_image': url});

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
                        padding: EdgeInsets.only(top: 30),
                        alignment: Alignment.center,
                        child: Stack(children: [
                          // ignore: unnecessary_null_compxarison
                          Userr.sphotoUrl != ""
                              ? CircleAvatar(
                                  radius: 120.0,
                                  backgroundImage:
                                      NetworkImage(Userr.sphotoUrl),
                                  /*: FileImage(ProfilePage._image!)
                                    as ImageProvider,*/
                                  backgroundColor: Colors.transparent,
                                )
                              : CircleAvatar(
                                  radius: 100.0,
                                  backgroundColor: kappLightDarkenColor,
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
                                      return Container(
                                        color: kappLightDarkenColor,
                                        child: Padding(
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
                                                  imgFromCamera();
                                                  updateUrl();

                                                  setState(() {});
                                                  Navigator.pop(context);
                                                  /*
                                                  //ProfilePage.camera = true;
                                                  
                                                  setState(() {});
                                                  */
                                                },
                                                child: ListTile(
                                                  leading:
                                                      Icon(Icons.photo_camera),
                                                  title: Text("Take photos"),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  // ProfilePage.file = true;
                                                  imgFromGallery();
                                                  updateUrl();
                                                  setState(() {});
                                                  Navigator.pop(context);
                                                  /*
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
                                                */

                                                  // ÇALIŞIYOR
                                                  /*
                                                  
                                                  */
                                                },
                                                child: ListTile(
                                                  title: Text("Choose photo"),
                                                  leading: Icon(Icons.folder),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('Users')
                                                      .doc(Userr.sUid)
                                                      .update({'image': ""});

                                                  updateUrl();

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
                                        ),
                                      );
                                    });
                              },
                              child: CircleAvatar(
                                backgroundColor: kappLightDarkenColor,
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
                      /*
                      Center(
                        child: InkWell(
                          onTap: () =>
                              Navigator.pushNamed(context, ProfileQrPage.id),
                          child: Container(
                            width: ,
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
*/
                      Container(
                          alignment: Alignment.center,
                          height: 60,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                        RoundedRectangleBorder(
                                            side:
                                                BorderSide(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                overlayColor: MaterialStateProperty.all<Color>(
                                    Color.fromARGB(255, 102, 102, 147)),
                                shadowColor: MaterialStateProperty.all<Color>(
                                    Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xFF1D1D35))),
                            onPressed: () {
                              Navigator.pushNamed(context, ProfileQrPage.id);
                            },
                            child:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              Text(
                                "Show Qr",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.qr_code,
                                size: 20,
                                color: Colors.white,
                              )
                            ]),
                          )),
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
