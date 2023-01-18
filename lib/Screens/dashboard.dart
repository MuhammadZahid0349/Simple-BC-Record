import 'package:bc_info/Screens/addmember.dart';
import 'package:bc_info/Screens/search_collection.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: ListStudentPage(bcName: bcName),
      body: SearchCollection(),
      /////////////////////////////
      floatingActionButton: Container(
        height: 40,
        width: 40,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Color(0xff08296c),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddStudentPage()));
            },
            // tooltip: 'Increment',
            child: Icon(
              Icons.add,
            ),
          ),
        ),
      ), // Th
    );
  }
}
