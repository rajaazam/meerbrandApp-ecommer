import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String? image;
  final dynamic price;
  final String? name;
  final String? description;
  SingleProduct({this.image, this.name,this.description, this.price});
  @override
  Widget build(BuildContext context) {
    double width, height;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Card(
      child: Container(
         //height: height * 0.3,
         //width: width * 0.2 * 2 + 10,
        // width: double.infinity,
        height: 200,
        width: 150,
         
       
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                child: Container(
                  
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(image!),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    "\$ ${price.toString()}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Color(0xff9b96d6)),
                  ),
                  Expanded(
                    child: Container(
                      //height:35,
                     // width: 50,
                      child: Text(
                        name!,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}