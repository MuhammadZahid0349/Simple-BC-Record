//updating student data

Future<void> updateUser(id, name, status, date, members) {
  return members
      .doc(id)
      .update({'name': name, 'status': status, 'date': date})
      .then((value) => print("Member detaile's Updated"))
      .catchError((error) => print("Failed to Update Details!!: $error"));
}
