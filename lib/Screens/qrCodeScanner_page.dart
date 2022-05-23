import 'dart:io';

import 'package:chatchain/Classes/userr.dart';
import 'package:chatchain/Screens/friend_info_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../Services/firebase_auth_service.dart';

class QrCodeScannerPage extends StatefulWidget {
  const QrCodeScannerPage({Key? key}) : super(key: key);
  static String id = "qrCodeScanner_page";

  @override
  State<QrCodeScannerPage> createState() => _QrCodeScannerPageState();
}

class _QrCodeScannerPageState extends State<QrCodeScannerPage> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode = null;
  Userr? friend_user;
  bool showError = true;
  bool already = false;
  var user;
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();

    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
            borderWidth: 10,
            borderRadius: 10,
            borderLength: 10,
            borderColor: Theme.of(context).accentColor,
            cutOutSize: MediaQuery.of(context).size.width * 0.8),
      );

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((barcode) {
      setState(() {
        this.barcode = barcode;
      });
    });
  }

  getFriend(String uid) async {
    print("oye");
    friend_user = await FirebaseAuthService().getFriendData(uid);
    user = await FirebaseAuthService().getUserData();
    /*FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Friends")
        .get()
        .then((value) {
      value.docs.map((e) {
        var a = e.get("uid");
        print(a);
        if (a == barcode!.code.toString()) {
          setState(() {
            already = true;
          });
        }
      });
    }); */
    if (friend_user != null && user != null) {
      print("Buldum");

      Future.delayed(Duration(milliseconds: 0), () {
        setState(() {
          showError = false;
        });
      });
    } else {
      Future.delayed(Duration(milliseconds: 0), () {
        setState(() {
          showError = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (barcode != null && showError == true) {
      goFriendInfo();
    }

    return showError == true
        ? Scaffold(
            appBar: AppBar(
              title: Text("Scan QR"),
              centerTitle: true,
            ),
            body: Stack(
              alignment: Alignment.center,
              children: [
                buildQrView(context),
                Positioned(bottom: 10, child: buildResult())
              ],
            ),
          )
        : FriendInfoPage(
            friend_user!.name,
            friend_user!.surname,
            "",
            "",
            barcode!.code.toString(),
            user!.uid,
            user.name,
            user.surname,
            user!.photUrl,
            friend_user!.photoUrl);
  }

  Widget buildResult() {
    return Text(
      barcode == null ? 'Scan a code' : '${barcode!.code}',
      maxLines: 3,
      style: TextStyle(color: Colors.white),
    );
  }

  goFriendInfo() async {
    if (barcode?.code != null) {
      await getFriend(barcode!.code.toString());
    }
  }
}
