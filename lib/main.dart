import 'package:firebase_2_26/auth/check_user.dart';
import 'package:firebase_2_26/auth/login_page.dart';
import 'package:firebase_2_26/auth/phone_auth/otp_page.dart';
import 'package:firebase_2_26/auth/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'auth/phone_auth/phone_auth.dart';

import 'firestore_db/send_data.dart';

import 'firestore_db/show_data.dart';


//firebase project name - firebase-testing-2-0
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


 //already written in home page
  //   logOut()async {
  //
  //   FirebaseAuth.instance.signOut().then((value){
  //
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
  //   });
  // }
  //




  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home:LoginPage()
    );
  }
}

