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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  data: 'My name is Baris',
                  version: QrVersions.auto,
                  size: 320,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Column(
            children: [
              Text("0xffSAFSAdf2334921sfFADSFDA"),
              InkWell(
                  onTap: () {
                    Clipboard.setData(
                        ClipboardData(text: "0xffSAFSAdf2334921sfFADSFDA"));
                    setState(() {
                      isCopied = true;
                    });
                  },
                  child: !isCopied
                      ? Icon(Icons.copy)
                      : Text(
                          "Copied",
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ))
            ],
          )
        ],
      ),
    );
  }
}
