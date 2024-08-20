import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:spark/components/custom_botton.dart';
import 'package:spark/components/custom_textfield.dart';
import 'package:spark/components/square_tile.dart';

class LogInPage extends StatelessWidget {
  LogInPage({super.key});

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(224, 224, 224, 1),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                ),
                // Icon(
                //   Icons.lock,
                //   size: 80,
                // ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Spark",
                      style: TextStyle(
                          color: Colors.blue[900],
                          fontWeight: FontWeight.bold,
                          fontSize: 40),
                    ),
                    Container(
                      height:70 ,
                      color: Colors.transparent,
                        child: Lottie.asset('lib/images/log.json',
                            fit: BoxFit.contain))
                  ],
                ),
                
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Login to your Account",
                  style: TextStyle(
                      color: Color.fromARGB(255, 66, 66, 66), fontSize: 16),
                ),
                SizedBox(
                  height: 25,
                ),
                CustomTextfiled(
                  controller: userNameController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextfiled(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forget Password?",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                CustomButton(
                  onTap: signUserIn,
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Or sign in with",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(imagePath: 'lib/images/google.png'),
                    const SizedBox(
                      width: 15,
                    ),
                    SquareTile(imagePath: 'lib/images/facebook.jpg'),
                    const SizedBox(
                      width: 15,
                    ),
                    SquareTile(imagePath: 'lib/images/apple.png'),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      "Sign up",
                      style: TextStyle(
                          color: const Color.fromRGBO(33, 150, 243, 1), fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
