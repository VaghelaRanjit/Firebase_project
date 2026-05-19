import 'package:firebase_2_26/auth/forgot_password.dart';
import 'package:firebase_2_26/auth/signup_page.dart';
import 'package:firebase_2_26/firestore_db/show_data.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/material.dart';

import '../home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Enter required fields!"),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password,).then((value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ShowData()));
      });
      // Only navigate if login successful
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => HomePage()),
      // );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Error: ${e.message}"),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

backgroundColor: Colors.cyanAccent,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: email,
                decoration: InputDecoration(
                  hint: Text('E-mail'),
                  prefixIcon: Icon(Icons.mail),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                obscureText: true,
                controller: password,
                decoration: InputDecoration(

                  hint: Text('Password'),
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(

                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  login(email.text.trim(), password.text.trim());
                },
                child: Container(
                  height: 60,
                  width: 380,
                  decoration: BoxDecoration(
                    color: Colors.black,

                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text(' New User ?'),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
                    child: Text(
                      'SignUp Here',
                      style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ForgotPassword()),
                  );
                },
                child: Text('Forgot Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
