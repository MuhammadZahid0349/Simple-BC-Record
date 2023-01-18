import 'package:bc_info/Screens/update_student.dart';
import 'package:bc_info/firebase/Data%20CRUD/delete_datafb.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListStudentPage extends StatefulWidget {
  final String bcName;
  const ListStudentPage({Key? key, required this.bcName}) : super(key: key);

  @override
  State<ListStudentPage> createState() => _ListStudentPageState(bcName);
}

class _ListStudentPageState extends State<ListStudentPage> {
  _ListStudentPageState(String bcName);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> studentStream =
        FirebaseFirestore.instance.collection(widget.bcName).snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: studentStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print("Something is wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];

          snapshot.data?.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();

          ///////////////////////////////////////
          return SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    child: Table(
                      border: TableBorder.all(),
                      // defaultColumnWidth: IntrinsicColumnWidth(),
                      columnWidths: const <int, TableColumnWidth>{
                        1: FixedColumnWidth(120), //2nd column width
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(children: [
                          TableCell(
                              child: Container(
                                  height: 40,
                                  color: Color(0xff08296c),
                                  child: Center(
                                    child: Text(
                                      'Name',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontFamily: 'Times New Roman'),
                                    ),
                                  ))),
                          ///////////////
                          TableCell(
                              child: Container(
                                  height: 40,
                                  color: Color(0xff08296c),
                                  child: Center(
                                    child: Text('Status',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Times New Roman',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  ))),
                          //////////////////////////
                          TableCell(
                              child: Container(
                                  height: 40,
                                  color: Color(0xff08296c),
                                  child: Center(
                                    child: Text('Action',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Times New Roman',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  ))),
                        ]),
                        //////////////////////////////////////
                        for (var i = 0; i < storedocs.length; i++) ...[
                          TableRow(children: [
                            TableCell(
                                child: Container(
                              height: 40,
                              child: Center(
                                child: Text(
                                  storedocs[i]['name'],
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            )),
                            ////////////////////////////

                            TableCell(
                                child: Container(
                              height: 40,
                              child: Center(
                                child: Text(
                                  storedocs[i]['status'],
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: storedocs[i]['status'] == "Payed"
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                              ),
                            )),

                            ///////////////////////////
                            TableCell(
                                child: Container(
                              height: 40,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  storedocs[i]['status'] == "Unpayed"
                                      ? IconButton(
                                          onPressed: () {
                                            CollectionReference members =
                                                FirebaseFirestore.instance
                                                    .collection(widget.bcName);
                                            print(widget.bcName);

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateStudentPage(
                                                          id: storedocs[i]
                                                              ['id'],
                                                          collectionName:
                                                              widget.bcName,
                                                        )));
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Color(0xff08296c),
                                          ))
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              left: 12.0, right: 12),
                                          child: Icon(
                                            FontAwesomeIcons.userCheck,
                                            color: Colors.green,
                                            size: 20,
                                          ),
                                        ),
                                  //////////////////////////////////////////////////
                                  IconButton(
                                      onPressed: () {
                                        CollectionReference members =
                                            FirebaseFirestore.instance
                                                .collection(widget.bcName);
                                        deleteUser(storedocs[i]['id'], members);
                                        // print(storedocs);
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )),
                                ],
                              ),
                            ))
                          ]),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
