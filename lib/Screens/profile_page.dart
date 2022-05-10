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

  Future<File?> takePhoto() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.camera);

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(onPressed: () async {
        File? f = await takePhoto();
        ProfilePage._image = f;
        setState(() {});
      }),
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
                                ? NetworkImage(
                                    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/Ataturk1930s.jpg/220px-Ataturk1930s.jpg")
                                : FileImage(ProfilePage._image!)
                                    as ImageProvider,
                            backgroundColor: Colors.transparent,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 20,
                            child: InkWell(
                              onTap: () async {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
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
                            width: 100,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(border: Border.all()),
                            padding: EdgeInsets.symmetric(vertical: 15),
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
