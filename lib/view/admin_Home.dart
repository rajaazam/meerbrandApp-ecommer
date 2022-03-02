


import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:meerbrand/view/product.dart';


class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  // Stream?  postStream = FirebaseFirestore.instance.collection('posts').snapshots();
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
   CollectionReference posts = FirebaseFirestore.instance.collection('posts');
 

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(title: Text('Admin Home page'),),
     

      body: Container(
       child: Column(children: [
            Expanded(
                child: Container(
              margin: const EdgeInsets.only(top: 10),
              child: StreamBuilder<QuerySnapshot>(
                stream: posts.snapshots(),
                // stream: postStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      String id = document.id;
                      data["id"] = id;

                      return ProductPage(data: data);
                    }).toList(),
                  );
                },
              ),
            ),
            ),
          // SizedBox(height:30),
          
            
            
          ])),
    );
  }
}