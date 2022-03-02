import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meerbrand/provider/category_provider.dart';
import 'package:meerbrand/provider/product_provider.dart';
import 'package:meerbrand/view/home.dart';
import 'package:meerbrand/view/login.dart';
import 'package:meerbrand/view/signup.dart';
import 'package:meerbrand/view/wellcom.dart';
import 'package:provider/provider.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryProvider>(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xff746bc9),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const HomePage();
            } else {
              return const Login();
            }
          },
        ),
      ),
    );
  }
}









// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   final Future<FirebaseApp> _initialization = Firebase.initializeApp();

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       // Initialize FlutterFire:
//       future: _initialization,
//       builder: (context, snapshot) {
//         // Check for errors
//         if (snapshot.hasError) {
//           return Container();
//         }

//         // Once complete, show your application
//         if (snapshot.connectionState == ConnectionState.done) {
//           return
          
    
//       MaterialApp(
//           debugShowCheckedModeBanner: false,
//           theme:ThemeData(
//             scaffoldBackgroundColor: Color(0xff2b2b2b),
//           appBarTheme: const AppBarTheme(
//             color: Color(0xff2b2b2b),
//           ),
//           ),
            
//             home: WelcomePage(),
//              routes: {
//           "/login":(context)=>Login(),
//           '/signup':(context)=>SignUp(),
//           '/home':(context)=> HomePage()

//        },
            
//             );
        
//         }

//         // Otherwise, show something whilst waiting for initialization to complete
//         return Container();
//       },
//     );
//   }
// }