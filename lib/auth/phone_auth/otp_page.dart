import 'dart:developer';

import 'package:firebase_2_26/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class OtpPage extends StatefulWidget {
  final String verificationId;
 const  OtpPage({super.key,required this.verificationId});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController otpController = TextEditingController();
    return  Scaffold(
      appBar: AppBar(
title: Text('OTP Screen'),
      centerTitle: true,),

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Enter the OTP",
                  suffixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                  )
              ),
            ),
            SizedBox(height: 10,),

            GestureDetector(
              onTap: ()async{


                try{
                  PhoneAuthCredential credential = await PhoneAuthProvider.credential(verificationId: widget.verificationId,
                      smsCode: otpController.text.toString());
                  FirebaseAuth.instance.signInWithCredential(credential).then((value)=> {



                    Navigator.push(context,MaterialPageRoute(builder: (context)=> HomePage()))
                  });



                }catch(ex){log(ex.toString());

                }
              },
              child: Container(
                height: 50,
                width: 380,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black
                ),
                child: Center(child: Text('Verify Phone Number',style: TextStyle(color: Colors.white,fontSize: 20),)),
              ),
            )

          ],
        ),
      ),
    );
  }
}
