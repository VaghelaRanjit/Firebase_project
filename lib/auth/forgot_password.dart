import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();

  forgotpassword(String email) async {
    if (email == "") {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Enter an Email To Reset Password"),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
        automaticallyImplyLeading: false,
        title: Text('Forgot Password'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hint: Text('E-mail'),
                prefixIcon: Icon(Icons.mail),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                forgotpassword(emailController.text.trim());
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
                    "Reset Password",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
