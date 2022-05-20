// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:chatchain/Services/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfileQrPage extends StatefulWidget {
  static String id = "profile_qr_page";

  @override
  State<ProfileQrPage> createState() => _ProfileQrPageState();
}

class _ProfileQrPageState extends State<ProfileQrPage> {
  bool isCopied = false;
  String hashValue = FirebaseAuth.instance.currentUser!.uid.toString();

  void showSnackBar(String hashValue) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 5),
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.fixed,
      content: Container(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            hashValue,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          Text("Hash value is copied !",
              style: TextStyle(color: Colors.black, fontSize: 12)),
        ],
      )),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.white,
            child: Center(
              child: Container(
                color: Colors.white,
                child: QrImage(
                  data: hashValue,
                  version: QrVersions.auto,
                  size: 250,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Column(
            children: [
              Text(
                hashValue,
                style: TextStyle(fontWeight: FontWeight.w100, fontSize: 15),
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: hashValue));
                    setState(() {
                      isCopied = true;
                      showSnackBar(hashValue);
                    });
                  },
                  child: !isCopied
                      ? Icon(Icons.copy)
                      : Text(
                          "Copied",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ))
            ],
          )
        ],
      ),
    );
  }
}
