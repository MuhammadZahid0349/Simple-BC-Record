import 'package:flutter/material.dart';

Future<void> addUser(members, name, selectedType, date) {
  print("Member Added");
  return members
      .add({'name': name, 'status': selectedType, 'date': date})
      .then((value) => print('Member Added'))
      .catchError((error) => print("Failed to Add Member: $error"));
}
