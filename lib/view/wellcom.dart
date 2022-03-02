import 'package:flutter/material.dart';
import 'package:meerbrand/view/login.dart';
import 'package:meerbrand/view/signup.dart';

// class WelcomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 80),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Container(
//                 height: 500,
//                 width: double.infinity,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: <Widget>[
//                     Container(
//                       height: 350,
//                       width: double.infinity,
//                       decoration: const BoxDecoration(
//                           image: DecorationImage(
//                               fit: BoxFit.cover,
//                               image: AssetImage("images/logo.jfif"))),
//                     ),
//                     const Text(
//                       "Welcome",
//                       style: TextStyle(
//                         fontSize: 35,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     Container(
//                       height: 60,
//                       width: double.infinity,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      
//                         children: const <Widget>[
//                           Text(
//                             "Ready To Start Shopping Sign Up",
//                             style: TextStyle(fontSize: 18),
//                           ),
//                           Text(
//                             "To get Started",
//                             style: TextStyle(fontSize: 18),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       height: 45,
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         // shape: RoundedRectangleBorder(
//                         //     borderRadius: BorderRadius.circular(10)
//                         //     ),
//                         child: const Text(
//                           "Sign Up",
//                           style: TextStyle(fontSize: 18, color: Colors.white),
//                         ),
//                        // color: Color(0xff746bc9),
//                         onPressed: () {
//                           Navigator.of(context).pushReplacement(
//                             MaterialPageRoute(
//                               builder: (ctx) => SignUp(),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         const Text(
//                           "Already have an account?",
//                           style: TextStyle(
//                             fontSize: 18,
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.of(context).pushReplacement(
//                               MaterialPageRoute(
//                                 builder: (ctx) => Login(),
//                               ),
//                             );
//                           },
//                           child: const Text(
//                             "Login",
//                             style: TextStyle(
//                               fontSize: 18,
//                               color: Color(0xff7746bc9),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }











class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  
  

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Center(
                child: Image.asset('images/logo.jfif'),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "Welcome To Merr Brand",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  Column(
                    children: const [
                      Text("Order any cloths form our Merr brand",
                      style: TextStyle(
                      fontSize: 20,
                     // fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),),
                    //   Text("Make reservation in real- time",
                    //   style: TextStyle(
                    //   fontSize: 20,
                    //  // fontWeight: FontWeight.bold,
                    //   color: Colors.white
                    // ),)
                    ],
                  ),
          
                
                  //button(name: 'Login', color: Colors.green,textColor: Colors.white),
                 // button(name: 'SignUp', color: Colors.green,textColor: Colors.white),
                Container(
                  height: 45,
                 width: 300,
                 decoration: BoxDecoration(
                   color: Colors.green,
                   borderRadius: BorderRadius.circular(30),
                   
                 ),
                  child: TextButton(onPressed: (){
                    Navigator.pushNamed(context, '/login');
                  },child: Text('Login',style: TextStyle(color: Colors.white,
                  fontSize: 15
                  ),),
                  
                  ),
                ),
                 Container(
                  height: 45,
                 width: 300,
                 decoration: BoxDecoration(
                   color: Colors.green,
                   borderRadius: BorderRadius.circular(30),
                   
                 ),
                  child: TextButton(onPressed: (){
                     Navigator.pushNamed(context, '/signup');
                  },child: Text('SignUp',style: TextStyle(color: Colors.white,
                  fontSize: 15
                  ),),
                  
                  ),
                )
           
               
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}