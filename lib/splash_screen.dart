import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:spark/auth_page.dart';
import 'package:spark/current_location.dart';
import 'package:spark/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AuthPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: const Color.fromRGBO(13, 71, 161, 1),
          child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                            'Spark',
                            style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700, fontSize: 50),
                          ),
        
                          Container(
                      height:100 ,
                      color: Colors.transparent,
                        child: Lottie.asset('lib/images/ani.json',
                            fit: BoxFit.contain))
        
                ],
              )),
        ),
      ),
    );
  }
}
