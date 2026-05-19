import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart.';

import 'auth/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  logOut()async {

    FirebaseAuth.instance.signOut().then((value){

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(

        actions: [GestureDetector(
            onTap: (){
              logOut();
            },

            child: Icon(Icons.logout)),
        SizedBox(width: 20,)],



        automaticallyImplyLeading: false,

        title: Text("Home Screen"),centerTitle: true,),


      body: Center(
        child: Text("Home Screen"),
      ),
    );
  }
}
