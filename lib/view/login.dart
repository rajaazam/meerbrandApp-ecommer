

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meerbrand/view/forgot_password.dart';
import 'package:meerbrand/view/home.dart';
import 'package:meerbrand/view/signup.dart';
import 'package:meerbrand/widgets/changescreen.dart';
import 'package:meerbrand/widgets/mybutton.dart';
import 'package:meerbrand/widgets/mytextformField.dart';
import 'package:meerbrand/widgets/passwordtextformfield.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
bool isLoading = false;
String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = new RegExp(p);
final TextEditingController email = TextEditingController();
final TextEditingController userName = TextEditingController();
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
final TextEditingController password = TextEditingController();

bool obserText = true;

class _LoginState extends State<Login> {
  void submit() async {
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore db = FirebaseFirestore.instance;
    try {
      setState(() {
        isLoading = true;
      });
     final UserCredential user = await auth
          .signInWithEmailAndPassword(
              email: email.text, password: password.text);

            final DocumentSnapshot snapshot = 
               await db.collection("users").doc(user.user!.uid).get();
        final data = snapshot.data();
              
       
      print(user);
    } on PlatformException catch (error) {
      var message = "Please Check Your Internet Connection ";
      if (error.message != null) {
        message = error.message!;
      }
      _scaffoldKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(message.toString()),
          duration: Duration(milliseconds: 2000),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      _scaffoldKey.currentState!.showSnackBar(SnackBar(
        content: Text(error.toString()),
        duration: const Duration(milliseconds: 2000),
        backgroundColor: Theme.of(context).primaryColor,
      ));
    }
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => HomePage()));
    setState(() {
      isLoading = false;
    });

    setState(() {
      isLoading = false;
    });

    
  }

  void vaildation() async {
    if (email.text.isEmpty && password.text.isEmpty) {
      _scaffoldKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text("Both Flied Are Empty"),
        ),
      );
    } else if (email.text.isEmpty) {
      _scaffoldKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text("Email Is Empty"),
        ),
      );
    } else if (!regExp.hasMatch(email.text)) {
      _scaffoldKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text("Please Try Vaild Email"),
        ),
      );
    } else if (password.text.isEmpty) {
      _scaffoldKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text("Password Is Empty"),
        ),
      );
    } else if (password.text.length < 5) {
      _scaffoldKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text("Password  Is Too Short"),
        ),
      );
     }
      
    
    else {
      submit();
    }
  }

  Widget _buildAllPart() {
    return Expanded(
      flex: 3,
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(

                height: 100,
                width: 100,
                child:Image.asset('images/logo.jfif',fit: BoxFit.cover,) ,),
            Column(
              children: <Widget>[
                 
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextFormField(
                  name: "Email",
                  controller: email,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPassword(),
                              ),
                            )
                          },
                          child: const Text(
                            'Forgot Password ?',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                PasswordTextFormField(
                  obserText: obserText,
                  name: "Password",
                  controller: password,
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    setState(() {
                      obserText = !obserText;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                isLoading == false
                    ? MyButton(
                        onPressed: () {
                          vaildation();
                        },
                        name: "Login",
                        
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChangeScreen(
                        name: "SignUp",
                        whichAccount: "I Have Not Account!",
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) => SignUp(),
                            ),
                          );
                        }),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      key: _scaffoldKey,
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
             
             
              _buildAllPart(),
            ],
          ),
        ),
      ),
    );
  }
}




// Color orangeColors = Color(0xffF5591F);
// Color orangeLightColors = Color(0xffF2861E);

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final  TextEditingController emailController= TextEditingController();
//   final  TextEditingController passwordController= TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//        // padding: EdgeInsets.only(bottom: 10),
//         child: Column(
//           children: [
//             HeaderContiner(
//               "Log In Free",
//             ),
//             SizedBox(height: 30,),
//             Expanded(
//                 flex: 1,
//                 child: Container(
//                   margin: EdgeInsets.only(top: 10, left: 20, right: 20),
//                   child: Column(
//                    // mainAxisSize: MainAxisSize.max,
//                     children: [
//                        _textInput(hint: 'Email',
//                        conterller: emailController,
                       
//                         icon: Icons.email),
//                        SizedBox(height: 20,),
                     
//                       _textInput(hint: 'Password',
//                       conterller: passwordController,
//                        icon: Icons.vpn_key),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                         TextButton(onPressed: (){}, child: Text('Forget password?'))
//                       ],),
//                       Container(
//                           child: Center(
//                         child: ButtomWidget(
//                           btntxt: 'Log In',
//                           onclick: () {
//                             Navigator.pushNamed(context, '/home');
//                           },
//                         ),
//                       )),
//                       SizedBox(height: 30,),


//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           RichText(
//                               text: const TextSpan(children: [
//                             TextSpan(
//                                 text: " Don't have an account?  ",
//                                 style: TextStyle(color: Colors.black)),
                               
//                             // TextSpan(
//                             //     text: 'Signup',
//                             //     style: TextStyle(color: orangeLightColors))
//                           ]
//                           )
//                           ),
//                           TextButton(onPressed: (){
//                             Navigator.pushNamed(context, '/signup');
//                           }, child: Text('Sign Up'))
//                         ],
//                       )
//                     ],
//                   ),
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
// }

// // new cls
// class HeaderContiner extends StatelessWidget {
//   final text;
//   HeaderContiner(this.text);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.3,
//       decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [orangeColors, orangeLightColors],
//             end: Alignment.bottomCenter,
//             begin: Alignment.topCenter,
//           ),
//           borderRadius:
//               const BorderRadius.only(bottomLeft: Radius.circular(100))),
//       child: Stack(
//         children: [
//           Positioned(
//               bottom: 10,
//               right: 20,
//               child: Text(
//                 text,
//                 style: const TextStyle(
                  
//                   fontSize: 20, color: Colors.white),
//                   textAlign: TextAlign.right,
//               )),
//           Center(
//             child: Image.asset(
//               'images/logo.jfif',
//               height: 100,
//               width: 100,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// // widget

// Widget _textInput({conterller, hint, icon}) {
//   return Container(
//     margin: const EdgeInsetsDirectional.only(top: 10),
//     decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.all(
//           Radius.circular(22),
//         )),
//     padding: const EdgeInsets.only(left: 10),
//     child: TextField(
//       controller: conterller,
//       decoration: InputDecoration(
//           prefixIcon: Icon(icon), hintText: hint,
//            border: InputBorder.none),
//     ),
//   );
// }

// ///2
// class ButtomWidget extends StatelessWidget {
//   String? btntxt;
//   var onclick;
//   ButtomWidget({this.btntxt, this.onclick});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onclick,
//       child: Container(
//         width: double.infinity,
//         height: 40,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [orangeColors, orangeLightColors],
//             begin: Alignment.centerRight,
//             end: Alignment.centerLeft,
//             // colors: [orangeLightColors]
//           ),
//           borderRadius: BorderRadius.all(Radius.circular(100)),
//         ),
//         alignment: Alignment.center,
//         child: Text(
//           btntxt!,
//           style: const TextStyle(
//               fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//       ),
//     );
//   }
// }
