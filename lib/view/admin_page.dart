import 'dart:io';


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:meerbrand/view/admin_Home.dart';
import 'package:meerbrand/view/home.dart';
import 'package:meerbrand/view/product.dart';
import 'package:path/path.dart' as path;

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  // Stream?  postStream = FirebaseFirestore.instance.collection('posts').snapshots();
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  CollectionReference posts = FirebaseFirestore.instance.collection('posts');
   TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  late String imagePath;

  @override
  Widget build(BuildContext context) {

    void pickImage() async {
      final ImagePicker _picker = ImagePicker();
      final image = await _picker.pickImage(source: ImageSource.gallery);
      // print(image.path);
      //// basename=path.basename(image.path);
      setState(() {
        imagePath = image!.path;
      });
    }

    void submit() async {
      try {
        String name = nameController.text;
        String description = descriptionController.text;
        String price= pricecontroller.text;
        String imageName = path.basename(imagePath);
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref('/$imageName'); //dart interplotion
        File file = File(imagePath);
        await ref.putFile(file);
        String downloadURl = await ref.getDownloadURL();
        FirebaseFirestore db = FirebaseFirestore.instance;
        await db.collection("posts").add({
          "title": name,
          "description": description,
          "price":price,
          "url": downloadURl,
        });
         ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(
         backgroundColor: Colors.orangeAccent,
         content: Text('Pic  is  upload succesfly',
         style: TextStyle(fontSize: 18.0,color: Colors.black),))
     );

        print('post is upload  succcesfly');
        nameController.clear();
        descriptionController.clear();
        pricecontroller.clear();
         Navigator.pushReplacement(context,MaterialPageRoute(builder:
          (context)=>AdminHomePage())) ;
        
    
        // print(downloadURl);
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('Admin page'),
    //  leading: IconButton(icon:Icon(Icons.arrow_back),
    //   onPressed:() {
    //     Navigator.of(context).pop();
    //   }
    //     )
      
      ),
    
      body: Container(
     
          
          child: Column(children: [
             
            TextFormField(
              controller: nameController,
              style: const TextStyle(
                fontSize: 30,
              ),
              decoration: const InputDecoration(
                // fillColor: Colors.green,

                labelStyle: TextStyle(fontSize: 30),
                // icon: Icon(Icons.email),
                // counterStyle: TextStyle(fontSize: 30,
                // ),
                labelText: 'Enter Name ',
              ),
            ),
            SizedBox(
              height: 10,
            ),
             SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: pricecontroller,
              style: const TextStyle(
                fontSize: 30,
              ),
              decoration: const InputDecoration(
                
                labelStyle: TextStyle(fontSize: 30),
                
                labelText: 'Enter price',
              ),
            ),
            TextFormField(
              controller: descriptionController,
              style: const TextStyle(
                fontSize: 30,
              ),
              decoration: const InputDecoration(
                
                labelStyle: TextStyle(fontSize: 30),
                
                labelText: 'Enter description',
              ),
            ),
            ElevatedButton(
              onPressed: pickImage,
              child: const Text(
                'pick image',
                style: TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton(
                onPressed: submit,
                child: const Text(
                  'submit',
                  style: TextStyle(fontSize: 20),
                )
                ),
            
          ])),
    );
  }
}