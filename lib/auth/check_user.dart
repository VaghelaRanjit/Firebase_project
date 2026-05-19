import 'package:firebase_2_26/auth/login_page.dart';
import 'package:firebase_2_26/firestore_db/show_data.dart';
import 'package:firebase_2_26/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {




    @override
    Widget build(BuildContext context) {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        return ShowData();
      } else {
        return LoginPage();
      }
    }



}
