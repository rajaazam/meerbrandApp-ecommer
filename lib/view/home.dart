// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

//import 'package:carousel_pro/carousel_pro.dart';
import 'package:meerbrand/model/categoryicon.dart';
import 'package:meerbrand/model/usermodel.dart';
import 'package:meerbrand/provider/category_provider.dart';
import 'package:meerbrand/provider/product_provider.dart';
import 'package:meerbrand/view/about.dart';
import 'package:meerbrand/view/admin_page.dart';
import 'package:meerbrand/view/checkout.dart';
import 'package:meerbrand/view/contactus.dart';
import 'package:meerbrand/view/detailscreen.dart';
import 'package:meerbrand/view/listproduct.dart';
import 'package:meerbrand/view/profilescreen.dart';
import 'package:meerbrand/widgets/singeproduct.dart';
import 'package:provider/provider.dart';
import '../model/product.dart';
import '../widgets/notification_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

Product? menData;
CategoryProvider? categoryProvider;
ProductProvider? productProvider;

Product? womenData;

Product? bulbData;

Product? smartPhoneData;

class _HomePageState extends State<HomePage> {
  Widget _buildCategoryProduct({String? image, int? color}) {
    return CircleAvatar(
      maxRadius: height * 0.1 / 2.1,
      backgroundColor: Color(color!),
      child: Container(
        height: 40,
        child: Image(
            // color: Colors.white,
            image: NetworkImage(
              image!,
            ),
            fit: BoxFit.cover),
      ),
    );
  }

  late double height, width;
  bool homeColor = true;

  bool checkoutColor = false;

  bool aboutColor = false;

  bool contactUsColor = false;
  bool profileColor = false;
  bool adminColor = false;
  late MediaQueryData mediaQuery;
  Widget _testDrawer() {
    return Column(
      children: const [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
              // image: DecorationImage(
              //   fit: BoxFit.cover,
              //   image: AssetImage('images/background.jpg'),
              // ),
              ),
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage('images/man.jpg'),
          ),
          accountName: Text(
            "Azam ",
            style: TextStyle(color: Colors.black),
          ),
          accountEmail:
              Text("Ali@gmail.com", style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }

  Widget _buildUserAccountsDrawerHeader() {
    List<UserModel> userModel = productProvider!.userModelList;
    return Column(
        children: userModel.map((e) {
      return UserAccountsDrawerHeader(
        accountName: Text(
          e.userName!,
          style: const TextStyle(color: Colors.black),
        ),
        currentAccountPicture: const CircleAvatar(
          backgroundColor: Colors.white,
          child: Text('AZam'),
          // backgroundImage:
          // AssetImage('images/man.jpg'),
          //   e.userImage == null
          //    ? const AssetImage("images/userImage.png")
          //    : NetworkImage(e.userImage),
        ),
        decoration: const BoxDecoration(color: Color(0xfff2f2f2)),
        accountEmail:
            Text(e.userEmail!, style: const TextStyle(color: Colors.black)),
      );
    }).toList());
  }

  //AssetImage('images/man.jpg'),
  Widget _buildMyDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          _testDrawer(),

          // _buildUserAccountsDrawerHeader(),
          ListTile(
            selected: homeColor,
            onTap: () {
              setState(() {
                homeColor = true;
                contactUsColor = false;
                checkoutColor = false;
                aboutColor = false;
                profileColor = false;
              });
            },
            leading: const Icon(Icons.home),
            title: const Text("Home"),
          ),
          // ListTile(
          //   selected: adminColor,
          //   onTap: () {
          //     setState(() {
          //       adminColor = true;
          //       checkoutColor = false;
          //       contactUsColor = false;
          //       homeColor = false;
          //       profileColor = false;
          //       aboutColor = false;
          //     });
          //     Navigator.of(context).pushReplacement(
          //         MaterialPageRoute(builder: (ctx) => AdminPage()));
          //   },
          //   leading: const Icon(Icons.admin_panel_settings_sharp),
          //   title: const Text("Admin"),
          // ),
          ListTile(
            selected: checkoutColor,
            onTap: () {
              setState(() {
                checkoutColor = true;
                contactUsColor = false;
                homeColor = false;
                profileColor = false;
                aboutColor = false;
              });
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => const CheckOut()));
            },
            leading: const Icon(Icons.shopping_cart),
            title: const Text("Checkout"),
          ),
          ListTile(
            selected: aboutColor,
            onTap: () {
              setState(() {
                aboutColor = true;
                contactUsColor = false;
                homeColor = false;
                profileColor = false;
                checkoutColor = false;
              });
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => const About()));
            },
            leading: const Icon(Icons.info),
            title: const Text("About"),
          ),
          ListTile(
            selected: profileColor,
            onTap: () {
              setState(() {
                aboutColor = false;
                contactUsColor = false;
                homeColor = false;
                profileColor = true;
                checkoutColor = false;
              });
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => const ProfilePage(),
                ),
              );
            },
            leading: const Icon(Icons.info),
            title: const Text("Profile"),
          ),
          ListTile(
            selected: contactUsColor,
            onTap: () {
              setState(() {
                contactUsColor = true;
                checkoutColor = false;
                profileColor = false;
                homeColor = false;
                aboutColor = false;
              });
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => const ContactUs()));
            },
            leading: const Icon(Icons.phone),
            title: const Text("Contant Us"),
          ),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  Widget _icon() {
    return Container(
      width: double.infinity,
      height: 150,
      margin: EdgeInsets.only(top: 15),
      child: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return _catergorylist(context);
          }),
    );
  }

  // Widget _buildImageSlider() {
  //   return SizedBox(
  //     height: height * 0.3,
  //     child: Carousel(
  //       autoplay: true,
  //       showIndicator: false,
  //       images: const [
  //         AssetImage("images/man.jpg"),
  //         AssetImage("images/women.jpg"),
  //         AssetImage("images/camera.jpg"),
  //       ],
  //     ),
  //   );
  // }
// new slider
 

   Widget Newslider() {
    return SizedBox(
      height: height * 0.3,
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 2.0,
          enlargeCenterPage: true,
        ),
        items: [
         Image.asset('images/man.jpg'),
         Image.asset('images/women.jpg'),
         Image.asset('images/camera.jpg'),
        ],
      ),
    );
  }


//
  Widget _buildDressIcon() {
    List<CategoryIcon>? dressIcon = categoryProvider!.getDressIcon;
    List<Product>? dress = categoryProvider!.getDressList;
    return Row(
        children: dressIcon!.map((e) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ListProduct(
                name: "dress",
                snapShot: dress,
              ),
            ),
          );
        },
        child: _buildCategoryProduct(image: e.image!, color: 0xff33dcfd),
      );
    }).toList());
  }

  Widget _buildShirtIcon() {
    List<Product>? shirts = categoryProvider!.getShirtList;
    List<CategoryIcon>? shirtIcon = categoryProvider!.getShirtIconData;
    return Row(
        children: shirtIcon.map((e) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ListProduct(
                name: "shirt",
                snapShot: shirts,
              ),
            ),
          );
        },
        child: _buildCategoryProduct(image: e.image!, color: 0xfff38cdd),
      );
    }).toList());
  }

  Widget _buildShoeIcon() {
    List<CategoryIcon> shoeIcon = categoryProvider!.getShoeIcon;
    List<Product>? shoes = categoryProvider!.getshoesList;
    return Row(
        children: shoeIcon.map((e) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ListProduct(
                name: "shoe",
                snapShot: shoes,
              ),
            ),
          );
        },
        child: _buildCategoryProduct(
          image: e.image!,
          // color:Colors.black,
          color: 0xff4ff2af,
        ),
      );
    }).toList());
  }

  Widget _buildPantIcon() {
    List<CategoryIcon> pantIcon = categoryProvider!.getPantIcon;
    List<Product>? pant = categoryProvider!.getPantList;
    return Row(
        children: pantIcon.map((e) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ListProduct(
                name: "pant",
                snapShot: pant,
              ),
            ),
          );
        },
        child: _buildCategoryProduct(
          image: e.image!,
          color: 0xff74acf7,
        ),
      );
    }).toList());
  }

  // new widget
  Widget _catergorylist(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DetailScreen()));
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                image: AssetImage('images/man.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: 100,
            height: 100,
          ),
          SizedBox(
            height: 10,
          ),
          Text('Shirt'),
        ],
      ),
    );
  }

  Widget _buildTieIcon() {
    List<CategoryIcon> tieIcon = categoryProvider!.getTieIcon;
    List<Product>? tie = categoryProvider!.getTieList;
    return Row(
        children: tieIcon.map((e) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ListProduct(
                name: "tie",
                snapShot: tie,
              ),
            ),
          );
        },
        child: _buildCategoryProduct(
          image: e.image!,
          color: 0xfffc6c8d,
        ),
      );
    }).toList());
  }

  Widget _buildCategory() {
    return Column(
      children: <Widget>[
        Container(
          height: height * 0.1 - 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const <Widget>[
              Text(
                "Categorie",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          height: 40,
          child: Row(
            children: <Widget>[
              // _icon(),
              Expanded(child: _buildDressIcon()),
              Expanded(child: _buildShirtIcon()),
              // Expanded(child: _buildShoeIcon()),
              Expanded(child: _buildPantIcon()),
              Expanded(child: _buildTieIcon()),
            ],
          ),
        ),
      ],
    );
  }


  Widget _buildFeature() {
    List<Product> featureProduct;

    featureProduct = productProvider!.getFeatureList;

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              "Featured",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => ListProduct(
                      name: "Featured",
                      isCategory: false,
                      snapShot: featureProduct,
                    ),
                  ),
                );
              },
              child: const Text(
                "View more",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        Row(
          children: productProvider!.getHomeFeatureList.map((e) {
            return Expanded(
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => DetailScreen(
                            image: e.image,
                            price: e.price,
                            name: e.name,
                            description: e.description,
                          ),
                        ),
                      );
                    },
                    child: SingleProduct(
                      image: e.image,
                      price: e.price,
                      name: e.name,
                      description: e.description,
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => DetailScreen(
                                image: e.image, price: e.price, name: e.name),
                          ),
                        );
                      },
                      child: SingleProduct(
                        image: e.image,
                        price: e.price,
                        name: e.name,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildNewAchives() {
    List<Product> newAchivesProduct = productProvider!.getNewAchiesList;
    return Column(
      children: <Widget>[
        Container(
          height: height * 0.1 - 30,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    "New Achives",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => ListProduct(
                            name: "NewAchvies",
                            isCategory: false,
                            snapShot: newAchivesProduct,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "View more",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Row(
            children: productProvider!.getHomeAchiveList.map((e) {
          return Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => DetailScreen(
                            image: e.image,
                            price: e.price,
                            name: e.name,
                            description: e.description,
                          ),
                        ),
                      );
                    },
                    child: SingleProduct(
                        image: e.image, price: e.price, name: e.name),
                  ),
                ),
                // SizedBox(width: 10,),
              ],
            ),
          );
        }).toList()),
      ],
    );
  }

 
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  void getCallAllFunction() {
    categoryProvider!.getShirtData();
    categoryProvider!.getDressData();
    categoryProvider!.getShoesData();
    categoryProvider!.getPantData();
    categoryProvider!.getTieData();
    categoryProvider!.getDressIconData();
    productProvider!.getNewAchiveData();
    productProvider!.getFeatureData();
    productProvider!.getHomeFeatureData();
    productProvider!.getHomeAchiveData();
    categoryProvider!.getShirtIcon();
    categoryProvider!.getshoesIconData();
    categoryProvider!.getPantIconData();
    categoryProvider!.getTieIconData();
    productProvider!.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    categoryProvider = Provider.of<CategoryProvider>(context);
    productProvider = Provider.of<ProductProvider>(context);
    getCallAllFunction();
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
        key: _key,
        drawer: _buildMyDrawer(),
        appBar: AppBar(
          title: const Text(
            "HomePage",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.grey[100],
          leading: IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () {
                _key.currentState!.openDrawer();
              }),
          actions: <Widget>[
            NotificationButton(),
          ],
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(children: <Widget>[
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                 // _buildImageSlider(),
                 Newslider(),

                  _buildCategory(),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildFeature(),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildNewAchives(),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),

            
          ]),
        ));
  }
}
