import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FilterPage extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  void userSignout(){
    FirebaseAuth.instance.signOut();
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
                'Filter Page is UnderConstruction \n you can only logout form here...' , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18)
                ,),
             SizedBox(height: 20,),
             Text("LOGIIN AS: "+user.email!),
                SizedBox(height: 20,),
           Text("To Logout click below Icon"),
                IconButton(onPressed: userSignout, icon: Icon(Icons.logout),),
          ],
        ),
      ),
    );
  }
}
