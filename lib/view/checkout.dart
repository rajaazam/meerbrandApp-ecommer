import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meerbrand/model/cartmodel.dart';
import 'package:meerbrand/provider/product_provider.dart';
import 'package:meerbrand/view/home.dart';
import 'package:meerbrand/widgets/checkout_singleproduct.dart';
import 'package:meerbrand/widgets/mybutton.dart';
import 'package:meerbrand/widgets/notification_button.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  TextStyle myStyle = const TextStyle(
    fontSize: 18,
  );
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late ProductProvider productProvider;

  var navigator;

  Widget _buildBottomSingleDetail({String? startName, String? endName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          startName!,
          style: myStyle,
        ),
        Text(
          endName!,
          style: myStyle,
        ),
      ],
    );
  }

  late User user;
  dynamic total;
  List<CartModel>? myList;

   void submit() async {
      try {
      
    if(productProvider.getCheckOutModelList.isNotEmpty){
       FirebaseFirestore db = FirebaseFirestore.instance;
        await db.collection("Orders").add({
             "Product": productProvider.getCheckOutModelList
             .map((c) =>{
                         "ProductName": c.name,
                          "ProductPrice": c.price,
                          "ProductQuetity": c.quentity,
                          "ProductImage": c.image,
                          "Product Color": c.color,
                          "Product Size": c.size,

             })
             .toList(),
              // "TotalPrice": total!.toStringAsFixed(2),
              //   "UserName": userName,
              //   "UserEmail": c.userEmail,
              //   "UserNumber": e.userPhoneNumber,
              //   "UserAddress": e.userAddress,
              //   "UserId": user.uid,
         
        });
         setState(() {
                myList!.clear();
              });

    }
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>HomePage())) ;
     ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(
         backgroundColor: Colors.orangeAccent,
         content: Text('Order is succesfly',
         style: TextStyle(fontSize: 18.0,color: Colors.black),))
     );
       // print('order  is upload  succcesfly');
      
        // print(downloadURl);
      } catch (e) {
        print(e);
      }
    }

  Widget _buildButton() {
    return Column(
        children: productProvider.userModelList.map((e) {
      return Container(
        height: 50,
       // color: Colors.red,
        child: MyButton(
          name: "Buy",
          onPressed: () {
            if (productProvider.getCheckOutModelList.isNotEmpty) {
              FirebaseFirestore.instance.collection("Order").add({
                "Product": productProvider.getCheckOutModelList
                    .map((c) => {
                          "ProductName": c.name,
                          "ProductPrice": c.price,
                          "ProductQuetity": c.quentity,
                          "ProductImage": c.image,
                          "Product Color": c.color,
                          "Product Size": c.size,
                        })
                    .toList(),
                "TotalPrice": total!.toStringAsFixed(2),
                "UserName": e.userName,
                "UserEmail": e.userEmail,
                "UserNumber": e.userPhoneNumber,
                "UserAddress": e.userAddress,
                "UserId": user.uid,
              });
              setState(() {
                myList!.clear();
              });

              productProvider.addNotification("Notification");
            } else {
              _scaffoldKey.currentState!.showSnackBar(
                const SnackBar(
                  content: const Text("No Item Yet"),
                ),
              );
            }
          },
        ),
      );
    }).toList());
  }

  @override
  void initState() { 
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    myList = productProvider.checkOutModelList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = FirebaseAuth.instance.currentUser!;
    double subTotal = 0;
    double discount = 3;
    double discountRupees;
    double shipping = 60;

    productProvider = Provider.of<ProductProvider>(context);
    productProvider.getCheckOutModelList.forEach((element) {
      subTotal += element.price! * element.quentity!;
    });

    discountRupees = discount / 100 * subTotal;
    total = subTotal + shipping - discountRupees;
    if (productProvider.checkOutModelList.isEmpty) {
      total = 0.0;
      discount = 0.0;
      shipping = 0.0;
    }

    return WillPopScope(
      onWillPop: () async {
        return navigator.pushReplacement<void, void>(
          MaterialPageRoute<void>(
              builder: (BuildContext context) => const HomePage()),
        );
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("CheckOut Page",
              style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => const HomePage(),
                ),
              );
            },
          ),
          actions: <Widget>[
            NotificationButton(),
          ],
        ),
      //   bottomNavigationBar:
      // Container(child:
      //   Column(
      //     children: [
      //       ElevatedButton(onPressed: (){}, child: Text('Buys'))
      //     ],
      //   ) 
      //  // _buildButton()
      //   ),

        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: ListView.builder(
                    itemCount: myList!.length,
                    itemBuilder: (ctx, myIndex) {
                      return CheckOutSingleProduct(
                        index: myIndex,
                        color: myList![myIndex].color,
                        size: myList![myIndex].size,
                        image: myList![myIndex].image,
                        name: myList![myIndex].name,
                        price: myList![myIndex].price,
                        quentity: myList![myIndex].quentity,
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildBottomSingleDetail(
                        startName: "Subtotal",
                        endName: "\$ ${subTotal.toStringAsFixed(2)}",
                      ),
                      _buildBottomSingleDetail(
                        startName: "Discount",
                        endName: "${discount.toStringAsFixed(2)}%",
                      ),
                      _buildBottomSingleDetail(
                        startName: "Shipping",
                        endName: "\$ ${shipping.toStringAsFixed(2)}",
                      ),
                      _buildBottomSingleDetail(
                        startName: "Total",
                        endName: "\$ ${total!.toStringAsFixed(2)}",
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: submit,
             
                  child: const Text(
                    'Buys',
                    style: TextStyle(fontSize: 20),
                  )
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
