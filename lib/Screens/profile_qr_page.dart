// ignore_for_file: prefer_const_constructors

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
  String hashValue = "0xff23sdf45DFC23njhFSCFHNS52";

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
