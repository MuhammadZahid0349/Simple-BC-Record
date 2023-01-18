import 'package:flutter/material.dart';

Future<void> deleteUser(id, members) {
  print("Member deleted $id");
  return members
      .doc(id)
      .delete()
      .then((value) => print('Member deleted'))
      .catchError((error) => print("Failed to delete Member: $error"));
}
