import 'package:bc_info/Screens/member_tables.dart';
import 'package:bc_info/Screens/search_collection.dart';
import 'package:flutter/material.dart';

class MembersList extends StatefulWidget {
  final String name;
  const MembersList({Key? key, required this.name}) : super(key: key);

  @override
  State<MembersList> createState() => _MembersListState();
}

class _MembersListState extends State<MembersList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Members"),
        backgroundColor: Color(0xff08296c),
      ),
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListStudentPage(bcName: widget.name)),
        ],
      ),
    );
  }
}
