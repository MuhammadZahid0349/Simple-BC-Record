import 'package:bc_info/Screens/forgot_password.dart';
import 'package:bc_info/Screens/signup_screen.dart';
import 'package:bc_info/Screens/user_main.dart';
import 'package:bc_info/Widgets/customized_textformfield.dart';
import 'package:bc_info/Widgets/customizted_btn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  var email = "";
  var password = "";

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final storage = new FlutterSecureStorage(); //keep login

  userLogin() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      /////////////keep login////////////////
      print(userCredential.user?.uid);
      await storage.write(key: "uid", value: userCredential.user?.uid);
      //////////////////////////////

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (contex) => UserMainState()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Color(0xff08296c),
            content: Text("No User found for that Email"),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Color(0xff08296c),
            content: Text("!! Wrong Password !!"),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 7, left: 5),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          // border: Border.all(color: Color(0xff08296c), width: 1),
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
                    ///////////////////
                    /////////////////
                    const Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        "\t Welcome Back!! \n\t\t\t\t\t\t\t  Glad to see you again",
                        style: TextStyle(
                          color: Color(0xff08296c),
                          fontWeight: FontWeight.bold,
                          fontSize: 27,
                          fontFamily: 'Pacifico',
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Color(0xff2891cf),
                              offset: Offset(5.0, 5.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(),
                    ),

                    ////////////////////////////
                    CustomizedTextFormfield(
                      myController: _emailController,
                      hintText: "Enter your Email",
                      isPassword: false,
                    ),
                    //////////////////////////////////////////
                    CustomizedTextFormfield(
                      myController: _passwordController,
                      hintText: "Enter your Password",
                      isPassword: true,
                    ),
                    ////////////////////////
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: 20, right: 15, bottom: 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ForgotPassword()));
                          },
                          child: Text(
                            'Forget Password ?',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xff08296c),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ),
                    //////////////////////////////
                    CustomizedBtn(
                      buttonText: "Login",
                      buttonColor: Color(0xff08296c),
                      txtColor: Colors.white,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            email = _emailController.text;
                            password = _passwordController.text;
                          });
                          userLogin();
                        }
                      },
                    ),

                    ////////////////////////////////////////////////////
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
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
                            "\t\t Or Login with \t\t",
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
                    SizedBox(
                      height: 12,
                    ),

                    ////////////////////////////////////////////////////
                    Padding(
                      padding: const EdgeInsets.all(8.0),
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
                    SizedBox(
                      height: 20,
                    ),
                    //////////////////////////////////////////////////
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 18, 8, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "Don't have an account?",
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
                                      builder: (_) => SignUpScreen()));
                            },
                            child: Text(
                              "Register Now",
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
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
