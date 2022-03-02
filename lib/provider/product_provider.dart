import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:meerbrand/model/cartmodel.dart';
import 'package:meerbrand/model/product.dart';
import 'package:meerbrand/model/usermodel.dart';

class ProductProvider with ChangeNotifier {
  List<Product> feature = [];
  late Product featureData;

  List<CartModel> checkOutModelList = [];
  late CartModel checkOutModel;

  List<UserModel> userModelList = [];
  late UserModel userModel;

  Future<void> getUserData() async {
    List<UserModel> newList = [];
    User? currentUser = FirebaseAuth.instance.currentUser;
    QuerySnapshot userSnapShot =
        await FirebaseFirestore.instance.collection("User").get();
    userSnapShot.docs.forEach(
      (element) {
        if (currentUser?.uid == (element.data() as dynamic)["UserId"]) {
          userModel = UserModel(
              userAddress: (element.data() as dynamic)["UserAddress"],
              // userImage:  (element.data() as dynamic)["UserImage"],
              userEmail: (element.data() as dynamic)["UserEmail"],
              userGender: (element.data() as dynamic)["UserGender"],
              userName: (element.data() as dynamic)["UserName"],
              userPhoneNumber: (element.data() as dynamic)["UserNumber"]);
          newList.add(userModel);
        }
        userModelList = newList;
      },
    );
  }

  List<UserModel> get getUserModelList {
    return userModelList;
  }

  void deleteCheckoutProduct(int index) {
    checkOutModelList.removeAt(index);
    notifyListeners();
  }

  void clearCheckoutProduct() {
    checkOutModelList.clear();
    notifyListeners();
  }

  void getCheckOutData(
      {int? quentity,
      dynamic price,
      String? name,
      String? color,
      String? size,
      String? image,
      String? description}) {
    checkOutModel = CartModel(
      color: color,
      size: size,
      price: price,
      name: name,
      image: image,
      quentity: quentity,
    );
    checkOutModelList.add(checkOutModel);
  }

  List<CartModel> get getCheckOutModelList {
    return List.from(checkOutModelList);
  }

  int get getCheckOutModelListLength {
    return checkOutModelList.length;
  }

  Future<void> getFeatureData() async {
    List<Product> newList = [];
    QuerySnapshot featureSnapShot = await FirebaseFirestore.instance
        .collection("products")
        .doc("QUM5U7ewhy2d1PpL5V4v")
        .collection("featureproduct")
        .get();
    featureSnapShot.docs.forEach(
      (element) {
        featureData = Product(
            image: (element.data() as dynamic)["image"],
            name: (element.data() as dynamic)["name"],
            price: (element.data() as dynamic)["price"],
            description: (element.data() as dynamic)["description"]);
        newList.add(featureData);
      },
    );
    feature = newList;
  }

  List<Product> get getFeatureList {
    return feature;
  }


  List<Product> homeFeature = [];
 Future<void> getHomeFeatureData() async {
    List<Product> newList = [];
    QuerySnapshot featureSnapShot =
        await FirebaseFirestore.instance.collection("homefeature").get();
    featureSnapShot.docs.forEach(
      (element) {
        featureData = Product(
            image: (element.data() as dynamic)["image"],
            name: (element.data() as dynamic)["name"],
            price: (element.data() as dynamic)["price"],
            description: (element.data() as dynamic)["description"]);
        newList.add(featureData);
      },
    );
    homeFeature = newList;
    notifyListeners();
  }

  List<Product> get getHomeFeatureList {
    return homeFeature;
  }

  List<Product> homeAchive = [];
  Future<void> getHomeAchiveData() async {
    List<Product> newList = [];
    QuerySnapshot featureSnapShot =
        await FirebaseFirestore.instance.collection("homeachive").get();
    featureSnapShot.docs.forEach(
      (element) {
        featureData = Product(
            image: (element.data() as dynamic)["image"],
            name: (element.data() as dynamic)["name"],
            price: (element.data() as dynamic)["price"],
            description: (element.data() as dynamic)["description"]);
        newList.add(featureData);
      },
    );
    homeAchive = newList;
    notifyListeners();
  }

  List<Product> get getHomeAchiveList {
    return homeAchive;
  }
  //for new main screen widget test

  List<Product> newhomeAchive = [];
  late Product newhomedata;
  Future<void> getNewHomeData() async {
    List<Product> newList = [];
    QuerySnapshot featureSnapShot =
        await FirebaseFirestore.instance.collection("newFeature").get();
    featureSnapShot.docs.forEach(
      (element) {
        newhomedata = Product(
            image: (element.data() as dynamic)["image"],
            name: (element.data() as dynamic)["name"],
            price: (element.data() as dynamic)["price"],
            description: (element.data() as dynamic)["description"]);
        newList.add(newhomedata);
      },
    );
    newhomeAchive = newList;
    notifyListeners();
  }

  List<Product> get getNewHomeList {
    return newhomeAchive;
  }

// end new widget

  List<Product> newAchives = [];
  late Product newAchivesData;
  Future<void> getNewAchiveData() async {
    List<Product> newList = [];
    QuerySnapshot achivesSnapShot = await FirebaseFirestore.instance
        .collection("products")
        .doc("QUM5U7ewhy2d1PpL5V4v")
        .collection("newachives")
        .get();
    achivesSnapShot.docs.forEach(
      (element) {
        newAchivesData = Product(
            image: (element.data() as dynamic)["image"],
            name: (element.data() as dynamic)["name"],
            price: (element.data() as dynamic)["price"],
            description: (element.data() as dynamic)["description"]);
        newList.add(newAchivesData);
      },
    );
    newAchives = newList;
    notifyListeners();
  }
  List<Product> get getNewAchiesList {
    return newAchives;
  }
// test for more wideget product
List<Product> myAchives = [];
  late Product myAchivesData;
  Future<void> getMyAchiveData() async {
    List<Product> newList = [];
    QuerySnapshot achivesSnapShot = await FirebaseFirestore.instance
        .collection("products")
        .doc("QUM5U7ewhy2d1PpL5V4v")
        .collection("NewFeature")
        .get();
    achivesSnapShot.docs.forEach(
      (element) {
        newAchivesData = Product(
            image: (element.data() as dynamic)["image"],
            name: (element.data() as dynamic)["name"],
            price: (element.data() as dynamic)["price"],
            description: (element.data() as dynamic)["description"]);
        newList.add(newAchivesData);
      },
    );
    myAchives = newList;
    notifyListeners();
  }
  List<Product> get getMyAchiesList {
    return myAchives;
  }

// end widget
  List<String> notificationList = [];
  void addNotification(String notification) {
    notificationList.add(notification);
  }

  int get getNotificationIndex {
    return notificationList.length;
  }

  get getNotificationList {
    return notificationList;
  }

  late List<Product>? searchList;
  void getSearchList({List<Product>? list}) {
    searchList = list;
  }

  List<Product> searchProductList(String query) {
    List<Product> searchShirt = searchList!.where((element) {
      return element.name!.toUpperCase().contains(query) ||
          element.name!.toLowerCase().contains(query);
    }).toList();
    return searchShirt;
  }
}
