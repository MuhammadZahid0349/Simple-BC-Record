import 'package:bc_info/Screens/login_screen.dart';
import 'package:bc_info/Screens/signup_screen.dart';
import 'package:bc_info/Widgets/customizted_btn.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,

          ////////////////////////////////////////////////
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Image(
                image: AssetImage('assets/bgt1.png'),
                fit: BoxFit.cover,
              ),
            ),

            Container(
              child: Image(
                image: AssetImage('assets/login.gif'),
                fit: BoxFit.cover,
              ),
            ),

            ///////////////////////////////////////
            CustomizedBtn(
              buttonText: "Login",
              buttonColor: Color(0xff08296c),
              txtColor: Colors.white,
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => LoginScreen()));
              },
            ),

            SizedBox(
              height: 15,
            ),
            CustomizedBtn(
              buttonText: "Register",
              buttonColor: Colors.white,
              txtColor: Color(0xff08296c),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => SignUpScreen()));
              },
            ),
            SizedBox(
              height: 25,
            ),

            //////////////////////////////////////
            TextButton(
              onPressed: () {},
              child: Text(
                'Continue as a Member',
                style: TextStyle(
                    color: Color(0xff08296c),
                    fontSize: 15,
                    decoration: TextDecoration.underline),
              ),
            ),
            ////////////////////////////////////
            Expanded(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 20),
                child: Image(
                  image: AssetImage('assets/bgt2.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
