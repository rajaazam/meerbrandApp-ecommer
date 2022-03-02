import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meerbrand/view/home.dart';
import 'package:meerbrand/view/login.dart';
import 'package:meerbrand/widgets/changescreen.dart';
import 'package:meerbrand/widgets/mybutton.dart';
import 'package:meerbrand/widgets/mytextformField.dart';
import 'package:meerbrand/widgets/passwordtextformfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = new RegExp(p);
bool obserText = true;
final TextEditingController email = TextEditingController();
final TextEditingController userName = TextEditingController();
final TextEditingController phoneNumber = TextEditingController();
final TextEditingController password = TextEditingController();
final TextEditingController address = TextEditingController();

bool isMale = true;
bool isLoading = false;

class _SignUpState extends State<SignUp> {
  void submit() async {
    FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore db = FirebaseFirestore.instance;
    UserCredential result;
    try {
      // UserCredential result;
      setState(() {
        isLoading = true;
      });
      final UserCredential user= await auth.
      createUserWithEmailAndPassword(
          email: email.text, password: password.text);
          await db.collection('Users').doc(user.user!.uid).set({
             "UserName": userName.text,
              "UserId": user.user!.uid,
              "UserEmail": email.text,
               "UserAddress": address.text,
               "UserGender": isMale == true ? "Male" : "Female",
                "UserNumber": phoneNumber.text,
          });
      print(user);
    //     FirebaseFirestore.instance.collection("User").doc(result.user!.uid).set({
    //   "UserName": userName.text,
    //   "UserId": result.user!.uid,
    //   "UserEmail": email.text,
    //   "UserAddress": address.text,
    //   "UserGender": isMale == true ? "Male" : "Female",
    //   "UserNumber": phoneNumber.text,
    // });
    } on PlatformException catch (error) {
      var message = "Please Check Your Internet Connection ";
      if (error.message != null) {
        message = error.message!;
      }
      _scaffoldKey.currentState!.showSnackBar(SnackBar(
        content: Text(message.toString()),
        duration: Duration(milliseconds: 600),
        backgroundColor: Theme.of(context).primaryColor,
      ));
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      _scaffoldKey.currentState!.showSnackBar(SnackBar(
        content: Text(error.toString()),
        duration: Duration(milliseconds: 600),
        backgroundColor: Theme.of(context).primaryColor,
      ));

      print(error);
     
    }
   
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => Login()));
    setState(() {
      isLoading = false;
    });
  }

  void vaildation() async {
    if (userName.text.isEmpty &&
        email.text.isEmpty &&
        password.text.isEmpty &&
        phoneNumber.text.isEmpty &&
        address.text.isEmpty) {
      _scaffoldKey.currentState!.showSnackBar(
        SnackBar(
          content: Text("All Flied Are Empty"),
        ),
      );
    } else if (userName.text.length < 3) {
      _scaffoldKey.currentState!.showSnackBar(
        SnackBar(
          content: Text("Name Must Be 6 "),
        ),
      );
    } else if (email.text.isEmpty) {
      _scaffoldKey.currentState!.showSnackBar(
        SnackBar(
          content: Text("Email Is Empty"),
        ),
      );
    } else if (!regExp.hasMatch(email.text)) {
      _scaffoldKey.currentState!.showSnackBar(
        SnackBar(
          content: Text("Please Try Vaild Email"),
        ),
      );
    } else if (password.text.isEmpty) {
      _scaffoldKey.currentState!.showSnackBar(
        SnackBar(
          content: Text("Password Is Empty"),
        ),
      );
    } else if (password.text.length < 5) {
      _scaffoldKey.currentState!.showSnackBar(
        SnackBar(
          content: Text("Password  Is Too Short"),
        ),
      );
    } else if (phoneNumber.text.length < 11 || phoneNumber.text.length > 11) {
      _scaffoldKey.currentState!.showSnackBar(
        SnackBar(
          content: Text("Phone Number Must Be 11 "),
        ),
      );
    } else if (address.text.isEmpty) {
      _scaffoldKey.currentState!.showSnackBar(
        SnackBar(
          content: Text("Adress Is Empty "),
        ),
      );
    } else {
      submit();
    }
  }

  Widget _buildAllTextFormField() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          MyTextFormField(
            name: "UserName",
            controller: userName,
          ),
          SizedBox(
            height: 10,
          ),
          MyTextFormField(
            name: "Email",
            controller: email,
          ),
          SizedBox(
            height: 10,
          ),
          PasswordTextFormField(
            obserText: obserText,
            controller: password,
            name: "Password",
            onTap: () {
              FocusScope.of(context).unfocus();
              setState(() {
                obserText = !obserText;
              });
            },
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isMale = !isMale;
              });
            },
            child: Container(
              height: 60,
              padding: EdgeInsets.only(left: 10),
              width: double.infinity,
              decoration: BoxDecoration(border: Border.all(color: Colors.white)),
              child: Center(
                child: Row(
                  children: [
                    Text(
                      isMale == true ? "Male" : "Female",
                      style: TextStyle(color: Colors.black87, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          MyTextFormField(
            name: "Phone Number",
            controller: phoneNumber,
          ),
          const SizedBox(
            height: 10,
          ),
          MyTextFormField(
            name: "Address",
            controller: address,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPart() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildAllTextFormField(),
          SizedBox(
            height: 10,
          ),
          isLoading == false
              ? MyButton(
                  name: "SignUp",
                  onPressed: () {
                    vaildation();
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChangeScreen(
                name: "Login",
                whichAccount: "I Have Already An Account!",
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => Login()
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      key: _scaffoldKey,
      body: ListView(
        children: [
          Container(
            height: 200,
         
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(

                height: 100,
                width: 100,
                child:Image.asset('images/logo.jfif',fit: BoxFit.cover,) ,),
                Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 500,
            child: _buildBottomPart(),
          ),
        ],
      ),
    );
  }
}

















// Color orangeColors = Color(0xffF5591F);
// Color orangeLightColors = Color(0xffF2861E);

// class SignupPage extends StatefulWidget {
//   const SignupPage({Key? key}) : super(key: key);

//   @override
//   _SignupPageState createState() => _SignupPageState();
// }

// class _SignupPageState extends State<SignupPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//        // padding: EdgeInsets.only(bottom: 10),
//         child: Column(
//           children: [
//             HeaderContiner(
//               "Sign Up Free",
//             ),
//             SizedBox(height: 10,),
//             Expanded(
//                 flex: 1,
//                 child: Container(
//                   margin: EdgeInsets.only(top: 10, left: 20, right: 20),
//                   child: Column(
//                    // mainAxisSize: MainAxisSize.max,
//                     children: [
//                       _textInput(hint: 'Full Name', icon: Icons.person),
//                       _textInput(hint: 'Email', icon: Icons.email),
//                       _textInput(hint: 'Phone No', icon: Icons.call),
//                       _textInput(hint: 'Password', icon: Icons.vpn_key),
//                       SizedBox(height: 30,),
//                       Container(
//                           child: Center(
//                         child: ButtomWidget(
//                           btntxt: 'SIGNUP',
//                           onclick: () {
//                           Navigator.pushNamed(context, '/login');
//                           },
//                         ),
//                       )),
//                       Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           RichText(
//                               text: const TextSpan(children: [
//                             TextSpan(
//                                 text: " Already a  Account ?",
//                                 style: TextStyle(color: Colors.black)),
//                             // TextSpan(
//                             //     text: 'SIGNIN',
//                             //     style: TextStyle(color: orangeLightColors))
//                           ]
//                           )
//                           ),
                       
//                        TextButton(onPressed: (){
//                             Navigator.pushNamed(context, '/login');
//                           }, child: Text('Log In')) ],
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
//             child: Container(
//               child: Image.asset(
//                 'images/logo.jfif',
//                 fit:BoxFit.cover,
//                 height: 100,
//                 width: 100,
//               ),
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
