import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_2_26/firestore_db/show_data.dart';
import 'package:flutter/material.dart';

class EditData extends StatefulWidget {

  final String docId;
  final String title;
  final String description;

  const EditData({
    super.key,
    required this.docId,
    required this.title,
    required this.description,
  });




  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  void initState() {
    super.initState();

    titleController.text = widget.title;
    descriptionController.text = widget.description;
  }

  Future<void> updateData() async {

    await FirebaseFirestore.instance
        .collection("rv576")
        .doc(widget.docId)
        .update({
      "title": titleController.text,
      "description": descriptionController.text,
    });

  //  log("Data Updated");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text("Data Updated Successfully"),
      ),
    );


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      appBar: AppBar(title: Text("Edit Data ",),
          backgroundColor: Colors.cyanAccent,
          automaticallyImplyLeading: false,
          centerTitle: true),

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
                  hintText: 'edit title',
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20),
              TextField(
                controller: descriptionController,

                decoration: InputDecoration(


                  hintText: 'edit description',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: ()async {

                await  updateData();

                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ShowData()));

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
                      'EDIT',
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
