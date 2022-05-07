import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfileQrPage extends StatelessWidget {
  static String id = "profile_qr_page";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Container(
          color: Colors.white,
          child: QrImage(
            data: 'This is a simple QR code',
            version: QrVersions.auto,
            size: 320,
          ),
        ),
      ),
    );
  }
}
