// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chatchain/Screens/profile_qr_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  static String id = "profile_screen";
  static File? _image;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool editMenu = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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

/*
  Future getImage(bool isCamera) async {
    File? image;
    if (isCamera) {
      image =
          (await ImagePicker().pickImage(source: ImageSource.camera)) as File?;
      // Capture a photo
    } else {
      image =
          (await ImagePicker().pickImage(source: ImageSource.gallery)) as File?;
    }
    setState(() {
      _image = image!;
    });
  }
  */
/*
  final snackBar = SnackBar(
    duration: Duration(seconds: 5),
    backgroundColor: Colors.white,
    behavior: SnackBarBehavior.fixed,
    content: Container(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            //ProfilePage.camera = true;
          },
          child: ListTile(
            leading: Text("Take photo"),
            trailing: Icon(Icons.camera_enhance),
          ),
        ),
        InkWell(
          onTap: () {
            // ProfilePage.file = true;
          },
          child: ListTile(
            leading: Text("Choose photo"),
            trailing: Icon(Icons.folder),
          ),
        )
      ],
    )),
  );
  */
  @override
  Widget build(BuildContext context) {
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
                          CircleAvatar(
                            radius: 100.0,
                            backgroundImage: ProfilePage._image == null
                                ? AssetImage('assets/images/no-profile.png')
                                : FileImage(ProfilePage._image!)
                                    as ImageProvider,
                            backgroundColor: Colors.transparent,
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
                                            InkWell(
                                              onTap: () async {
                                                //ProfilePage.camera = true;
                                                File? file =
                                                    await getPhoto(true);
                                                ProfilePage._image = file;
                                                setState(() {});
                                              },
                                              child: ListTile(
                                                leading: Text("Take photo"),
                                                trailing:
                                                    Icon(Icons.camera_enhance),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                // ProfilePage.file = true;
                                                File? file =
                                                    await getPhoto(false);
                                                ProfilePage._image = file;
                                                setState(() {});
                                              },
                                              child: ListTile(
                                                leading: Text("Choose photo"),
                                                trailing: Icon(Icons.folder),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                ProfilePage._image = null;
                                                setState(() {});
                                              },
                                              child: ListTile(
                                                leading: Text(
                                                  "Remove photo",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                                trailing: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
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
                                  Text("Barış")
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
                                  Text("Özçelikay")
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
                                  Text("baris.ozcelikay@tedu.edu.tr")
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  Text(
                                    "Phone : ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text("+90 598 764 65 43")
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
                                  Text("28th September 1999")
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
