import 'package:chatchain/Classes/userr.dart';
import 'package:chatchain/Screens/addFriend_page.dart';
import 'package:chatchain/Screens/chat_home_page.dart';
import 'package:chatchain/Services/firebase_auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<FirebaseAuthService>(context);
    return StreamBuilder<Userr?>(
        stream: authService.user,
        builder: (_, AsyncSnapshot<Userr?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final Userr? user = snapshot.data;
            return user == null ? const AddFriendPage() : const ChatHomePage();
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
/*
Scaffold(
      appBar: AppBar(title: Text("Firebase")),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            FirebaseFirestore.instance.collection("test").add({
              'timestamp': Timestamp.fromDate(DateTime.now()),
              'name': "Beyza"
            });
          }),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("test").snapshots(),
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          if (!snapshot.hasData) {
            print("No");
            return const SizedBox.shrink();
          }
          print("Yes");
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final docData = snapshot.data!.docs[index];
                final dateTime = (docData["timestamp"] as Timestamp).toDate();
                final name = docData["name"];
                return ListTile(
                  title: Text(name.toString()),
                );
              });
        },
      ),
    );
*/