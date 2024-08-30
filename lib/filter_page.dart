import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spark/login_page.dart';

class FilterPage extends StatefulWidget {
  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final user = FirebaseAuth.instance.currentUser!;

  void userSignout() {
    FirebaseAuth.instance.signOut();
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => LogInPage(),
    //   ),
    // );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Filter Page is UnderConstruction \n you can only logout form here...',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(
              height: 20,
            ),
            Text("LOGIIN AS: " + user.email!),
            SizedBox(
              height: 20,
            ),
            Text("To Logout click below Icon"),
            InkWell(
              onTap: userSignout,
              child: Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }
}
