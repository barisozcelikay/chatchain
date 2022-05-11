// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:chatchain/Screens/qrCodeScanner_page.dart';
import 'package:flutter/material.dart';

class AddFriendPage extends StatelessWidget {
  const AddFriendPage({Key? key}) : super(key: key);
  static String id = "addFriend_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
                      color: Color.fromARGB(255, 222, 0, 0),
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
                        context: context,
                        builder: (BuildContext context) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50.0, vertical: 30.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
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
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    floatingLabelStyle: TextStyle(
                                      color: Colors.red,
                                      fontSize: 18.0,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.5),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Enter',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0), //or 15.0
                    child: Container(
                      height: 80.0,
                      width: 80.0,
                      color: Color.fromARGB(255, 222, 0, 0),
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
