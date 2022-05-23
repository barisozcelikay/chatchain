// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:chatchain/Classes/userr.dart';
import 'package:chatchain/Screens/friend_info_page.dart';
import 'package:chatchain/Screens/qrCodeScanner_page.dart';
import 'package:chatchain/Services/firebase_auth_service.dart';
import 'package:chatchain/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddFriendPage extends StatefulWidget {
  const AddFriendPage({Key? key}) : super(key: key);
  static String id = "addFriend_page";

  @override
  State<AddFriendPage> createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  late String uid;
  bool isEnterValid = false;
  bool showError = false;
  Userr? friend_user;

  checkValue(String uid) {
    if (uid.length > 2) {
      setState(() {
        isEnterValid = true;
      });
    } else {
      setState(() {
        isEnterValid = false;
      });
    }
  }

  getFriend(String uid) async {
    friend_user = await FirebaseAuthService().getFriendData(uid);
    if (friend_user != null) {
      print("Buldum");
      setState(() {
        showError = false;
      });
    } else {
      setState(() {
        showError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kappLightDarkenColor,
        toolbarHeight: 75,
        title: Text("Add Friend"),
      ),
      body: Center(
          child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, QrCodeScannerPage.id),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0), //or 15.0
                    child: Container(
                      height: 80.0,
                      width: 80.0,
                      color: kappLightDarkenColor,
                      child:
                          Icon(Icons.qr_code, color: Colors.white, size: 50.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Add with Qr",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder: (BuildContext context,
                                StateSetter setState /*You can rename this!*/) {
                              return Container(
                                padding: MediaQuery.of(context).viewInsets,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50.0, vertical: 30.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        onChanged: (val) {
                                          setState(() {
                                            uid = val;
                                            checkValue(uid);
                                          });
                                        },
                                        cursorColor: Colors.white,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(0.0),
                                          labelText: 'Hash Value',
                                          hintText: 'Enter Hash Value',
                                          labelStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14.0,
                                          ),
                                          prefixIcon: Icon(
                                            Icons.person,
                                            color: Colors.red,
                                            size: 18,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade400,
                                                width: 2),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          floatingLabelStyle: TextStyle(
                                            color: Colors.red,
                                            fontSize: 18.0,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.red, width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      ),
                                      showError
                                          ? SizedBox(
                                              height: 20,
                                              child: Text(
                                                "User does not exist",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            )
                                          : SizedBox(),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      ElevatedButton(
                                        onPressed: isEnterValid
                                            ? () async {
                                                var user =
                                                    await FirebaseAuthService()
                                                        .getUserData();
                                                await getFriend(uid);
                                                if (showError == false) {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              FriendInfoPage(
                                                                  friend_user!
                                                                      .name,
                                                                  friend_user!
                                                                      .surname,
                                                                  "",
                                                                  "",
                                                                  uid,
                                                                  user!.uid,
                                                                  user.name,
                                                                  user.surname)));
                                                }
                                              }
                                            : null,
                                        child: Text(
                                          'Enter',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0), //or 15.0
                    child: Container(
                      height: 80.0,
                      width: 80.0,
                      color: kappLightDarkenColor,
                      child: Icon(Icons.numbers_sharp,
                          color: Colors.white, size: 50.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Add with Hash Value", style: TextStyle(fontSize: 15)),
              ],
            )
          ],
        ),
      )),
    );
  }
}
