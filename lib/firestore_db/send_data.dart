import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_2_26/firestore_db/show_data.dart';
import 'package:flutter/material.dart';

class SendData extends StatefulWidget {
  const SendData({super.key});

  @override
  State<SendData> createState() => _SendDataState();
}

class _SendDataState extends State<SendData> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  Future<bool> sendData(String title, String desc) async {
    if (title.isEmpty || desc.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter required fields"),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    await FirebaseFirestore.instance
        .collection('rv576')
        .add({
          // this will unique id automatically
          'title': title,
          'description': desc,
          "createdAt": FieldValue.serverTimestamp(),
        })
        .then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Data Added Successfully"),
              backgroundColor: Colors.green,
            ),
          );
        });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
        title: Text("Send data to FireStore "),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Enter title',
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20),
              TextField(
                controller: descController,

                decoration: InputDecoration(
                  hintText: 'Enter description',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  sendData(
                    titleController.text.toString(),
                    descController.text.toString(),
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShowData()),
                  );
                },
                child: Container(
                  height: 60,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.black,

                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: Center(
                    child: Text(
                      'SEND',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
