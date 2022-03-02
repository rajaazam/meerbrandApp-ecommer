import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
class ProductPage extends StatelessWidget {
  final Map data;
  const ProductPage({required this.data});

 


  @override
  Widget build(BuildContext context) {
  void deletePost()async{
    try{
           FirebaseFirestore db = FirebaseFirestore.instance;
          await  db.collection("posts").doc(data["id"]).delete();

    }catch(e){
      print(e);
    }
       }
     void editPost(){
      // showDialog(context: context, builder: (BuildContext  context){
      //   return editPage(data: data,);

      // }
     
     // );

  }
    
     return 

    SingleChildScrollView(
      child: Container(
       
              margin: EdgeInsets.only(top: 5,),
              
        decoration: BoxDecoration(
        //  color: Colors.lightGreen,
          border: Border.all(color: Colors.black, width: 1),
          
        ),
          padding: EdgeInsets.all(10),
        child: Column(
          children: [
            //Image.network(data["url"],
            //'url' != null ? Image.network(data["ural"]) : Container()
             
      
           
            Text(data["name"],style: TextStyle(fontSize: 20,  fontWeight:FontWeight.bold),),
            Text(data["price"],style: TextStyle(fontSize: 20,  fontWeight:FontWeight.bold),),
            Text(data["description"],style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
            //Row(
             // mainAxisAlignment: MainAxisAlignment.center,
             // children: const [
               // ElevatedButton(onPressed: deletePost, child: Text('Delete')),
                SizedBox(height: 5,),
                Container(
                  child: Column(
                    children: [
                      Image.network(data["url"],
             
              width: 200,
              height: 200,
              fit: BoxFit.cover,
                      // Container(
                      //   child:url != null ? Image.network(data["url"]) : Container()
                      //   // Image.network(data['url'],
                      //    //Image.network(data["url"],
             
            
                      //     ),
                       ) ],
                  ),
                )

                // Column(
                //   children: [
                //        ElevatedButton(onPressed: editPost, child:Text('Edit')),
                //   ],
                // )
            //  ],
           // ),
            
            
            
          
          
          ],
        ),
    
        
      ),
    );
  }
}