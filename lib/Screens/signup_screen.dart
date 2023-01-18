import 'package:bc_info/Screens/user_main.dart';
import 'package:bc_info/Widgets/customized_textfield.dart';
import 'package:bc_info/Widgets/customized_textformfield.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Widgets/customizted_btn.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  var username = "";
  var email = "";
  var password = "";
  var confirmPassword = "";

  bool _isVisible = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

//////////////////////////Sign Up + Registration /////////////
  registration() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
      await user!.updateDisplayName(username);
      await user.reload();
      user = auth.currentUser;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => UserMainState()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Color(0xff08296c),
            content: Text("Password Provided is too weak..."),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Color(0xff08296c),
            content: Text("Account already exists..."),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Color(0xff08296c),
            content: Text(e.code),
          ),
        );
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,

              ///////////////////////////////
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///////////////////
                    Row(children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 7, left: 5),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            // border:
                            //     Border.all(color: Color(0xff08296c), width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios_sharp,
                                color: Color(0xff08296c),
                              ),
                              onPressed: () => Navigator.pop(context)),
                        ),
                      ),

                      Container(
                        child: Text(
                          "   Hell",
                          style: TextStyle(
                            color: Color(0xff08296c),
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            fontFamily: 'Pacifico',
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Color(0xff1fb1e0),
                                offset: Offset(5.0, 5.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ////////////////////////////////////////////////////
                      Container(
                        margin: EdgeInsets.only(left: 1, top: 3),
                        height: 20,
                        width: 20,
                        child: Image(
                          image: AssetImage('assets/p3.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      //////////////////////////////////////////////
                      Container(
                        margin: EdgeInsets.only(left: 1, top: 3),
                        height: 20,
                        width: 20,
                        child: Image(
                          image: AssetImage('assets/p3.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        child: Text(
                          "\n Register yourself",
                          style: TextStyle(
                            color: Color(0xff08296c),
                            fontWeight: FontWeight.w500,
                            fontSize: 22,
                            fontFamily: 'Pacifico',
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Color(0xff1fb1e0),
                                offset: Offset(5.0, 5.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),

                    ////////////////////////////
                    CustomizedTextfield(
                      myController: _userNameController,
                      hintText: "Username",
                    ),
                    ///////////////////////////
                    CustomizedTextFormfield(
                      myController: _emailController,
                      hintText: "Email",
                      isPassword: false,
                    ),
                    //////////////////////////////////////////
                    CustomizedTextFormfield(
                      myController: _passwordController,
                      hintText: "Password",
                      isPassword: true,
                    ),
                    ////////////////////////
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 15),
                      child: TextFormField(
                        enableSuggestions: true,
                        obscureText: _isVisible ? false : true,
                        controller: _confirmPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Confirm Password';
                          } else if (_confirmPasswordController.text !=
                              _passwordController.text) {
                            return 'Please enter Correct Password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(_isVisible
                                ? Icons.remove_red_eye
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isVisible = !_isVisible;
                              });
                            },
                          ),
                          hintText: "Confirm Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),

                    ////////////////////////
                    SizedBox(
                      height: 17,
                    ),
                    //////////////////////////////
                    CustomizedBtn(
                      buttonText: "Register",
                      buttonColor: Color(0xff08296c),
                      txtColor: Colors.white,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            username = _userNameController.text;
                            email = _emailController.text;
                            password = _passwordController.text;
                            confirmPassword = _confirmPasswordController.text;
                          });

                          registration(); //sign up
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (_) => UserMainState()));
                        }
                      },
                    ),

                    ////////////////////////////////////////////////////
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 2,
                            width: MediaQuery.of(context).size.width * 0.15,
                            color: Color(0xff08296c),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            child: Image(
                              image: AssetImage('assets/p1.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Text(
                            "\t Or Register with \t",
                            style: TextStyle(color: Color(0xff08296c)),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            child: Image(
                              image: AssetImage('assets/p2.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            height: 2,
                            width: MediaQuery.of(context).size.width * 0.15,
                            color: Color(0xff08296c),
                          ),
                        ],
                      ),
                    ),
                    ////////////////////////////////////////////////////
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 60,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff08296c),
                                ),
                                BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: -8.0,
                                  blurRadius: 13.0,
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: Icon(
                                FontAwesomeIcons.facebookF,
                                color: Colors.blue,
                              ),
                              onPressed: () {},
                            ),
                          ),
                          ////////////////////////
                          Container(
                            height: 60,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff08296c),
                                ),
                                BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: -8.0,
                                  blurRadius: 13.0,
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: Icon(
                                FontAwesomeIcons.google,
                                color: Colors.blue,
                              ),
                              onPressed: () {},
                            ),
                          ),
                          /////////////////////////
                          Container(
                            height: 60,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff08296c),
                                ),
                                BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: -8.0,
                                  blurRadius: 13.0,
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: Icon(
                                FontAwesomeIcons.apple,
                                size: 28,
                                color: Colors.blue,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    //////////////////////////////////////////////////
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => LoginScreen()));
                              },
                              child: Text(
                                "Login Now",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
