import 'package:bc_info/Screens/login_screen.dart';
import 'package:bc_info/Widgets/customized_textformfield.dart';
import 'package:bc_info/Widgets/customizted_btn.dart';
import 'package:bc_info/firebase/Data%20CRUD/reset_passwordfb.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  var email = "";
  TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
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
                      padding: EdgeInsets.only(left: 20, right: 10),
                      child: Text(
                        "Forgot Password!!",
                        style: TextStyle(
                          color: Color(0xff08296c),
                          fontWeight: FontWeight.w400,
                          fontSize: 27,
                          fontFamily: 'Pacifico',
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.double,
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
                      padding: const EdgeInsets.all(25.0),
                      child: Container(
                        child: Text(
                          "Don't worry! It occurs. Please enter the email address which linked with your account",
                          style: TextStyle(
                            color: Color(0xff08296c),
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
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
                    ),

                    ////////////////////////////
                    CustomizedTextFormfield(
                      myController: _emailController,
                      hintText: "Enter your Email",
                      isPassword: false,
                    ),
                    ///////////////////////////////
                    SizedBox(
                      height: 20,
                    ),
                    //////////////////////////////
                    CustomizedBtn(
                      buttonText: "Send Email",
                      buttonColor: Color(0xff08296c),
                      txtColor: Colors.white,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            email = _emailController.text;
                          });
                          resetPassword(context, email);
                        }

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: new Text("Forgot Password!!"),
                              content: new Text("Email has been send!"),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: new Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
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
                            "\t\t * * * * * \t\t",
                            style: TextStyle(
                                color: Color(0xff08296c), fontSize: 20),
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
                      height: 100,
                    ),

                    ////////////////////////////////////////////////
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 50, 8, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "Remember Password ?",
                            style: TextStyle(
                              color: Color(0xff08296c),
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
                              "Login",
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

                    /////////////////////////////////////////////////
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 10),
                      child: Image(
                        image: AssetImage('assets/bgt2.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    /////////////////////////////////////////
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
