import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_2_26/firestore_db/send_data.dart';
import 'package:flutter/material.dart';

import 'edit_delete_data.dart';

class ShowData extends StatefulWidget {
  const ShowData({super.key});

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
        title: Text('Firebase Data'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("rv576")
            .orderBy("createdAt", descending: true)
            .snapshots(),

        builder: (context, snapshot) {
          //  Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          //  Error
          if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }

          //  No Data
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No data found"));
          }

          //  Data Show

          var docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var data = docs[index];

              return Padding(
                padding: const EdgeInsets.all(3.0),
                child: ListTile(
                  tileColor: Colors.cyanAccent,
                  // leading: CircleAvatar(child: Text("${index + 1}")),
                  leading: Container(child: Center(child: Text("${index+1}",style: TextStyle(color: Colors.white,fontSize: 20),)),decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)
                  ),height: 50,width: 50,),
                  title: Text("${data['title']}"),
                  subtitle: Text("${data['description']}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditData(
                                docId: data.id,
                                title: data['title'],
                                description: data['description'],
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.edit),
                      ),

                      IconButton(
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection("rv576")
                              .doc(data.id)
                              .delete();

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("Data Deleted"),
                            ),
                          );
                        },
                        icon: Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SendData()),
          );
        },
        child: Icon(Icons.add,color: Colors.white,size: 30,),
      ),
    );
  }
}
