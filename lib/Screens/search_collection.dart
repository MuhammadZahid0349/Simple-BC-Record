import 'package:bc_info/Screens/member_tables.dart';
import 'package:bc_info/Screens/members_list.dart';
import 'package:flutter/material.dart';

class SearchCollection extends StatefulWidget {
  const SearchCollection({Key? key}) : super(key: key);

  @override
  State<SearchCollection> createState() => _SearchCollectionState();
}

class _SearchCollectionState extends State<SearchCollection> {
  final bcNameController = TextEditingController();
  var bcName = "";

  @override
  void dispose() {
    bcNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Image(
              image: AssetImage('assets/bgt1.png'),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: TextFormField(
                controller: bcNameController,
                decoration: InputDecoration(
                    labelText: 'BC-Name',
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Color(0xff08296c),
                      ),
                      onPressed: () {
                        setState(() {
                          bcName = bcNameController.text;
                          print(bcName);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MembersList(name: bcName),
                              ));
                          // ListStudentPage(
                          //   name: bcName,
                          // );
                        });
                      },
                    ))),
          ),
        ],
      ),

      // ListStudentPage();
    );
  }
}
