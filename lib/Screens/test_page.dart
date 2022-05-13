import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Firebase")),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            FirebaseFirestore.instance
                .collection("test")
                .add({'timestamp': Timestamp.fromDate(DateTime.now())});
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
                return ListTile(
                  title: Text(dateTime.toString()),
                );
              });
        },
      ),
    );
  }
}
