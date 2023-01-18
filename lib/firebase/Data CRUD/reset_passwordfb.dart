import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

resetPassword(context, email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Color(0xff08296c),
        content: Text("Password Reset Email has been send!!"),
      ),
    );
  } on FirebaseException catch (e) {
    if (e.code == 'user-not-found') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xff08296c),
          content: Text("No User found for that Email"),
        ),
      );
    }
  }
}
