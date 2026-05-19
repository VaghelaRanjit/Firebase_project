import 'package:firebase_2_26/auth/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Future<void> signUp(String email, String password) async {
    if (email.isEmpty && password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Enter required fields!"),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    UserCredential? userCredential;
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        : email, password: password)
          .then((value) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.message}"),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
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
                controller: password,
                obscureText: true,
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
                  signUp(email.text.toString(), password.text.toString());
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
                      "SignUp",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                ),
                
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                Text('Already have an account ? '),
                SizedBox(width: 10,),
                GestureDetector(

                   onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
                   },
                    child: Text('Login Here',style: TextStyle(color: Colors.green),))
              ],)
            ],
          ),
        ),
      ),
    );
  }
}
