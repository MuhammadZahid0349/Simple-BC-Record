import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final username = FirebaseAuth.instance.currentUser!.displayName;
  final email = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;

  User? user = FirebaseAuth.instance.currentUser;
  var count = "1";
  verifyEmail() async {
    if (count == 1) {
      await user!.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xff08296c),
          content: Text("Verification Email has been sent..."),
        ),
      );
    }
//////////////////////////////////////////
    else if (user != null && !user!.emailVerified) {
      await user!.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xff08296c),
          content: Text("Verification Email has been sent..."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(children: [
        Text('User ID: $uid'),
        Text('User Name is $username'),
        Row(
          children: [
            Text('Email: $email'),
            user!.emailVerified
                ? Text('  verified')
                : TextButton(
                    onPressed: () {
                      verifyEmail();
                    },
                    child: Text('Verify Email'),
                  ),
          ],
        ),
        Text('Created: $creationTime'),
      ]),
    );
  }
}
