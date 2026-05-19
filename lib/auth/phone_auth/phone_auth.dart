import 'package:firebase_2_26/auth/phone_auth/otp_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {




  TextEditingController phoneController = TextEditingController();

  // Future<void> verifyPhone() async {
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: "+91${phoneController.text.trim()}",
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       await FirebaseAuth.instance.signInWithCredential(credential);
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text(e.message ?? "Verification Failed")),
  //       );
  //     },
  //     codeSent: (String verificationId, int? resendToken) {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => OtpPage(verificationId: verificationId),
  //         ),
  //       );
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {},
  //   );
  // }


  Future<void> verifyPhone() async {

    String phone = phoneController.text.trim();

    if (phone.isEmpty || phone.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Enter valid 10 digit phone number")),
      );
      return;
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91$phone",

      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
      },

      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? "Verification Failed")),
        );
      },

      codeSent: (String verificationId, int? resendToken) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpPage(verificationId: verificationId),
          ),
        );
      },

      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('Phone Auth'),
      centerTitle: true,),


      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter Phone Number",
                suffixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15)
                )
              ),
            ),
            SizedBox(height: 10,),

            GestureDetector(
              onTap: verifyPhone,
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
