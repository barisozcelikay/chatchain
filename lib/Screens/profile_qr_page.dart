import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfileQrPage extends StatelessWidget {
  static String id = "profile_qr_page";

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
            children: [Text("0xffSAFSAdf2334921sfFADSFDA"), Icon(Icons.copy)],
          )
        ],
      ),
    );
  }
}
