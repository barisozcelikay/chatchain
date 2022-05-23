// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, deprecated_member_use

import 'package:chatchain/Screens/aboutUs_page.dart';
import 'package:chatchain/Screens/welcome_page.dart';
import 'package:chatchain/Services/firebase_auth_service.dart';
import 'package:chatchain/constants.dart';
import 'package:chatchain/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Widgets/settingsCard.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final Uri _url = Uri.parse('google.com');

  Future _launchUrl() async {
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }

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

    return new_url;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text("Dark Mode")),
        SettingsCard(
          onPressed: () {},
          /*onPressed: () async {
              print("hello world");
              const url = 'https://blog.logrocket.com';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            */
          title: "Need Help",
          icon: Icons.help_outline,
        ),
        SettingsCard(
          onPressed: () {
            Navigator.pushNamed(context, AboutUsPage.id);
          },
          title: "About Us",
          icon: Icons.info_outline,
        ),
        SettingsCard(
          onPressed: () {
            Navigator.pushNamed(context, AboutUsPage.id);
          },
          title: "Privacy Policy",
          icon: Icons.privacy_tip_outlined,
        ),
        SettingsCard(
            onPressed: () {
              print(FirebaseAuth.instance.currentUser!.uid);
              FirebaseAuthService().signOut();
              print("Çıkış Yapıldı");

              print(FirebaseAuth.instance.currentUser!.uid);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomePage(true, false),
                  ),
                  (route) => false);
            },
            title: "Log Out",
            icon: Icons.output),
        SettingsCard(
          onPressed: () {
            showAlertDialog(context);
          },
          title: "Delete Account",
          icon: Icons.delete_outline,
        ),
      ],
    );
  }
}

showAlertDialog(BuildContext context) {
  // Create button

  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed: () => Navigator.of(context).pop(),
  );

  Widget deleteButton = FlatButton(
    color: Colors.red,
    child: Text(
      "Delete Account",
      style: TextStyle(color: Colors.white),
    ),
    onPressed: () async {
      var uid = FirebaseAuth.instance.currentUser!.uid;
      print(uid);

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

      final old_ref = FirebaseStorage.instance.refFromURL(new_url);

      await old_ref.delete();
      await FirebaseAuthService().deleteUser();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomePage(false, true),
          ),
          (route) => false);
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: kappLightDarkenColor,
    title: Text("Deleting Account"),
    content: Text("Are you sure to delete your account ?"),
    actions: [cancelButton, deleteButton],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

/*  Expanded(
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.privacy_tip_outlined,
                        size: 40,
                      ),
                      Text(
                        "Privacy Policy",
                        style: TextStyle(fontSize: 25),
                      )
                    ]))),*/
