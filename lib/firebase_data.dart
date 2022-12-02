import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

main() async {
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,);
  }
  final dref = FirebaseDatabase.instance.ref();
  late DatabaseReference databaseReference;

  setData() {
    dref.child("Info").set({
      'reading1': "01",
      'reading2': "02",
    });


  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}


class MyApp extends StatefulWidget {
  @override
  AddData createState() => AddData();
}

class AddData extends State<MyApp> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('lol'),
        actions: [
          TextButton(onPressed: setData, child: const Text("store data"))
        ],
      ),
    );
  }
}
