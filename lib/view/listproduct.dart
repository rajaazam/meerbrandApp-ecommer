import 'package:flutter/material.dart';
import 'package:meerbrand/model/product.dart';
import 'package:meerbrand/provider/category_provider.dart';
import 'package:meerbrand/provider/product_provider.dart';
import 'package:meerbrand/view/detailscreen.dart';
import 'package:meerbrand/view/home.dart';
import 'package:meerbrand/view/search_category.dart';
import 'package:meerbrand/view/search_product.dart';
import 'package:meerbrand/widgets/notification_button.dart';
import 'package:meerbrand/widgets/singeproduct.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ListProduct extends StatelessWidget {
 // late CategoryProvider categoryProvider;
 // late ProductProvider productProvider;
  final String? name;
  bool? isCategory = true;
  final List<Product>? snapShot;
     
   ListProduct({Key? key, 
     this.name,
     this.isCategory,
     this.snapShot,
  }) : super(key: key);

  Widget _buildTopName() {
    return Column(
      children: <Widget>[
        Container(
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    name!,
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildMyGridView(context) {
    final Orientation orientation = MediaQuery.of(context).orientation;

    return Container(
      height: 700,
      child: GridView.count(
        crossAxisCount: 2,
        //crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
        childAspectRatio: orientation == Orientation.portrait ? 0.8 : 0.9,
        scrollDirection: Axis.vertical,
        children: snapShot!
            .map(
              (e) => GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (ctx) => DetailScreen(
                            image: e.image!,
                            name: e.name,
                            price: e.price,
                            description: e.description,
                          )));
                },
                child: SingleProduct(
                  price: e.price,
                  image: e.image,
                  name: e.name,
                  description: e.description,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  late CategoryProvider categoryProvider;
  late ProductProvider productProvider;
  Widget _buildSearchBar(context) {
    return isCategory == true
        ? IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              categoryProvider.getSearchList(list: snapShot);
              showSearch(context: context, delegate: SearchProduct());
            },
          )
        : IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              productProvider.getSearchList(list: snapShot);
              showSearch(context: context, delegate: SearchProduct());
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    categoryProvider = Provider.of<CategoryProvider>(context);
    productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
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
                  builder: (ctx) => HomePage(),
                ),
              );
            }),
        actions: <Widget>[
          _buildSearchBar(context),
          NotificationButton(),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: <Widget>[
            _buildTopName(),
            const SizedBox(
              height: 10,
            ),
            _buildMyGridView(context),
          ],
        ),
      ),
    );
  }
}