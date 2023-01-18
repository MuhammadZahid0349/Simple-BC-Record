import 'package:bc_info/Widgets/customizted_btn.dart';
import 'package:bc_info/firebase/Data%20CRUD/update_datafb.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpdateStudentPage extends StatefulWidget {
  final String id;
  final String collectionName;
  const UpdateStudentPage(
      {Key? key, required this.id, required this.collectionName})
      : super(key: key);

  @override
  State<UpdateStudentPage> createState() => _UpdateStudentPageState();
}

class _UpdateStudentPageState extends State<UpdateStudentPage> {
  final _formKey = GlobalKey<FormState>();

  List<String> statusList = ['Payed', 'Unpayed'];
  final dateController = TextEditingController();

  var selectedType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Member Details"),
        backgroundColor: Color(0xff08296c),
      ),
      body: Form(
          key: _formKey,
          //Getting specific data by id
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection(widget.collectionName)
                .doc(widget.id)
                .get(),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                print("Something went wrong");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              var data = snapshot.data!.data();
              var name = data!['name'];
              var status = data['status'];
              var date = data['date'];

              //////////////////////return data
              return ListView(
                children: [
                  Container(
                    child: Image(
                      image: AssetImage('assets/bgt1.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ////////////////////////////////
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                        initialValue: name,
                        autofocus: false,
                        onChanged: (value) => {name = value},
                        decoration: InputDecoration(
                          labelText: "Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          errorStyle:
                              TextStyle(color: Colors.redAccent, fontSize: 15),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Name';
                          }
                          return null;
                        },
                      )),
                  ////////////////////////////////////////
                  Container(
                    height: 60,
                    margin: EdgeInsets.only(top: 15, left: 30, right: 30),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey)),
                    child: DropdownButtonHideUnderline(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: DropdownButton(
                          items: statusList
                              .map((value) => DropdownMenuItem(
                                    child: Text(value),
                                    value: value,
                                  ))
                              .toList(),
                          value: selectedType,
                          onChanged: (value) {
                            setState(() {
                              selectedType = value;
                            });
                          },
                          isExpanded: true,
                          iconSize: 30,
                          iconEnabledColor: Color(0xff08296c),
                          hint: Text("$status"),
                        ),
                      ),
                    ),
                  ),

                  /////////////////////////////////
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    child: TextFormField(
                        controller: dateController, //editing controller
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.calendar_today,
                            color: Color(0xff08296c),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          // icon: Icon(Icons.calendar_today), //icon of text field
                          // labelText: "Date", //label text of field
                          hintText: ("$date"),
                        ),
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Fill this Filled';
                          }
                          return null;
                        },
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(), //get today's date
                              firstDate: DateTime(2000), //DateTime.now()
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('dd-MM-yyyy').format(pickedDate);

                            setState(() {
                              dateController.text = formattedDate.toString();
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Color(0xff08296c),
                                content: Text("Date is not selected"),
                              ),
                            );
                          }
                        }),
                  ),

                  //////////////////////////
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: CustomizedBtn(
                        buttonText: "Update",
                        buttonColor: Color(0xff08296c),
                        txtColor: Colors.white,
                        onPressed: () {
                          status = selectedType;
                          date = dateController.text;

                          CollectionReference members = FirebaseFirestore
                              .instance
                              .collection(widget.collectionName);
                          if (_formKey.currentState!.validate()) {
                            if (status == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Color(0xff08296c),
                                  content: Text("Status is Empty"),
                                ),
                              );
                            } else {
                              updateUser(
                                  widget.id, name, status, date, members);
                              Navigator.pop(context);
                            }
                          }
                        }),
                  ),
                ],
              );
            },
          )),
    );
  }
}
