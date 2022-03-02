import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:meerbrand/model/categoryicon.dart';
import 'package:meerbrand/model/product.dart';

class CategoryProvider with ChangeNotifier {
  List<Product>? shirt = [];
  Product? shirtData;
  List<Product>? dress = [];
  Product? dressData;
  List<Product>? shoes = [];
  Product? shoesData;
  List<Product>? pant = [];
  Product? pantData;
  List<Product>? tie = [];
  Product? tieData;
  
  List<CategoryIcon>? dressIcon = [];
  late CategoryIcon dressiconData;

  Future<void> getDressIconData() async {
    List<CategoryIcon>? newList = [];
    QuerySnapshot dressSnapShot = await FirebaseFirestore.instance
        .collection("categoryicon")
        .doc("XaCCZbjma3IbOdXuzFoA")
        .collection("dress")
        .get();
    for (var element in dressSnapShot.docs) {
        dressiconData = CategoryIcon
        (image: (element.data() as dynamic)['image']  );
        newList.add(dressiconData);
      }
    dressIcon = newList;
    notifyListeners();
  }

  List<CategoryIcon>? get getDressIcon {
    return dressIcon;
  }

  List<CategoryIcon> shirtIcon = [];
  late CategoryIcon shirticonData;
  Future<void> getShirtIcon() async {
    List<CategoryIcon> newList = [];
    QuerySnapshot shirtSnapShot = await FirebaseFirestore.instance
        .collection("categoryicon")
        .doc("XaCCZbjma3IbOdXuzFoA")
        .collection("shirt")
        .get();
    shirtSnapShot.docs.forEach(
      (element) {
        shirticonData = CategoryIcon(
          image: (element.data() as dynamic)["image"].toString());
        newList.add(shirticonData);
      },
    );
    shirtIcon = newList;
    notifyListeners();
  }

  List<CategoryIcon> get getShirtIconData {
    return shirtIcon;
  }

  List<CategoryIcon> shoesIcon = [];
  late CategoryIcon shoesiconData;
  Future<void> getshoesIconData() async {
    List<CategoryIcon> newList = [];
    QuerySnapshot shoesSnapShot = await FirebaseFirestore.instance
        .collection("categoryicon")
        .doc("XaCCZbjma3IbOdXuzFoA")
        .collection("shoe")
        .get();
    shoesSnapShot.docs.forEach(
      (element) {
        shoesiconData = CategoryIcon(image:(element.data() as dynamic)["image"]);
        newList.add(shoesiconData);
      },
    );
    shoesIcon = newList;
    notifyListeners();
  }

  List<CategoryIcon> get getShoeIcon {
    return shoesIcon;
  }

  List<CategoryIcon> pantIcon = [];
  late CategoryIcon panticonData;
  Future<void> getPantIconData() async {
    List<CategoryIcon> newList = [];
    QuerySnapshot pantSnapShot = await FirebaseFirestore.instance
        .collection("categoryicon")
        .doc("XaCCZbjma3IbOdXuzFoA")
        .collection("pant")
        .get();
    pantSnapShot.docs.forEach(
      (element) {
        panticonData = CategoryIcon(image:(element.data() as dynamic)["image"]);
        newList.add(panticonData);
      },
    );
    pantIcon = newList;
    notifyListeners();
  }

  List<CategoryIcon> get getPantIcon {
    return pantIcon;
  }

  List<CategoryIcon> tieIcon = [];
  late CategoryIcon tieIconData;
  Future<void> getTieIconData() async {
    List<CategoryIcon> newList = [];
    QuerySnapshot tieSnapShot = await FirebaseFirestore.instance
        .collection("categoryicon")
        .doc("XaCCZbjma3IbOdXuzFoA")
        .collection("tie")
        .get();
    tieSnapShot.docs.forEach(
      (element) {
        tieIconData = CategoryIcon(image: (element.data() as dynamic)["image"]);
        newList.add(tieIconData);
      },
    );
    tieIcon = newList;
    notifyListeners();
  }

  List<CategoryIcon> get getTieIcon {
    return tieIcon;
  }

  Future<void> getShirtData() async {
    List<Product> newList = [];
    QuerySnapshot shirtSnapShot = await FirebaseFirestore.instance
        .collection("category")
        .doc("BkMna1uI62ZHmVkQCSfr")
        .collection("shirt")
        .get();
    shirtSnapShot.docs.forEach(
      (element) {
        shirtData = Product(
            image: (element.data() as dynamic)["image"],
            name:  (element.data() as dynamic)["name"],
            price: (element.data() as dynamic)["price"],
             description:  (element.data() as dynamic)["description"]
             );
        newList.add(shirtData!);
      },
    );
    shirt = newList;
    notifyListeners();
  }

  List<Product>? get getShirtList {
    return shirt;
  }

  Future<void> getDressData() async {
    List<Product> newList = [];
    QuerySnapshot shirtSnapShot = await FirebaseFirestore.instance
        .collection("category")
        .doc("BkMna1uI62ZHmVkQCSfr")
        .collection("dress")
        .get();
    shirtSnapShot.docs.forEach(
      (element) {
        shirtData = Product(
            image:  (element.data() as dynamic)["image"],
            name:  (element.data() as dynamic)["name"],
            price: (element.data() as dynamic)["price"],
             description:  (element.data() as dynamic)["description"]
            );
        newList.add(shirtData!);
      },
    );
    dress = newList;
    notifyListeners();
  }

  List<Product>? get getDressList {
    return dress;
  }

  Future<void> getShoesData() async {
    List<Product> newList = [];
    QuerySnapshot shirtSnapShot = await FirebaseFirestore.instance
        .collection("category")
        .doc("BkMna1uI62ZHmVkQCSfr")
        .collection("shoes")
        .get();
    shirtSnapShot.docs.forEach(
      (element) {
        shirtData = Product(
            image:  (element.data() as dynamic)["image"],
            name:  (element.data() as dynamic)["name"],
            price:  (element.data() as dynamic)["price"]);
        newList.add(shirtData!);
      },
    );
    shoes = newList;
    notifyListeners();
  }

  List<Product>? get getshoesList {
    return shoes;
  }

  Future<void> getPantData() async {
    List<Product> newList = [];
    QuerySnapshot shirtSnapShot = await FirebaseFirestore.instance
        .collection("category")
        .doc("BkMna1uI62ZHmVkQCSfr")
        .collection("pant")
        .get();
    shirtSnapShot.docs.forEach(
      (element) {
        shirtData = Product(
            image:  (element.data() as dynamic)["image"],
            name:  (element.data() as dynamic)["name"],
            price: (element.data() as dynamic)["price"],
             description:  (element.data() as dynamic)["description"]
            );
        newList.add(shirtData!);
      },
    );
    pant = newList;
    notifyListeners();
  }

  List<Product>? get getPantList {
    return pant;
  }

  Future<void> getTieData() async {
    List<Product> newList = [];
    QuerySnapshot shirtSnapShot = await FirebaseFirestore.instance
        .collection("category")
        .doc("BkMna1uI62ZHmVkQCSfr")
        .collection("tie")
        .get();
    shirtSnapShot.docs.forEach(
      (element) {
        shirtData = Product(
            image: (element.data() as dynamic)["image"],
            name: (element.data() as dynamic)["name"],
            price:  (element.data() as dynamic)["price"],
             description:  (element.data() as dynamic)["description"]
            );
        newList.add(shirtData!);
      },
    );
    tie = newList;
    notifyListeners();
  }

  List<Product>? get getTieList {
    return tie;
  }

  late List<Product> searchList;
  void getSearchList({List<Product>? list}) {
    searchList = list!;
  }

  List<Product> searchCategoryList(String query) {
    List<Product> searchShirt = searchList.where((element) {
      return element.name!.toUpperCase().contains(query) ||
          element.name!.toLowerCase().contains(query);
    }).toList();
    return searchShirt;
  }
}