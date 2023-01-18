import 'package:bc_info/Widgets/customized_textfield.dart';
import 'package:bc_info/Widgets/customizted_btn.dart';
import 'package:bc_info/firebase/Data%20CRUD/add_data_fb.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({Key? key}) : super(key: key);

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formKey = GlobalKey<FormState>();

  var name = "";
  var status = "";
  var date = "";

  final nameController = TextEditingController();
  final statusController = TextEditingController();
  final dateController = TextEditingController();
  final bcNameController = TextEditingController();

  // final String bcName = "etc";

  @override
  void dispose() {
    nameController.dispose();
    statusController.dispose();
    dateController.dispose();
    bcNameController.dispose();
    super.dispose();
  }

  //adding student data

  // Future<void> addUser(members) {
  //   print("Member Added");
  //   return members
  //       .add({'name': name, 'status': selectedType, 'date': date})
  //       .then((value) => print('Member Added'))
  //       .catchError((error) => print("Failed to Add Member: $error"));
  // }

  // clearText() {
  //   nameController.clear();
  //   statusController.clear();
  //   dateController.clear();
  // }

  List<String> statusList = ['Payed', 'Unpayed'];

  var selectedType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Member'),
        backgroundColor: Color(0xff08296c),
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Image(
                  image: AssetImage('assets/bgt1.png'),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: CustomizedTextfield(
                    myController: bcNameController,
                    hintText: 'BC-Name',
                  )),

              Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: CustomizedTextfield(
                    myController: nameController,
                    hintText: 'Name',
                  )),
              ///////////////////////////
              Container(
                height: 60,
                margin: EdgeInsets.only(top: 15, left: 25, right: 25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
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
                      onChanged: (selectedSL) {
                        setState(() {
                          selectedType = selectedSL;
                        });
                      },
                      value: selectedType,
                      isExpanded: true,
                      iconSize: 30,
                      hint: Text('Status'),
                    ),
                  ),
                ),
              ),
              /////////////////////
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: TextFormField(
                    controller: dateController, //editing controller
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // icon: Icon(Icons.calendar_today), //icon of text field
                        labelText: "Enter Date" //label text of field
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

              //////////////////////////////////////
              Container(
                margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                child: CustomizedBtn(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        name = nameController.text;
                        status = statusController.text;
                        date = dateController.text;
                        String bcName = bcNameController.text;

                        CollectionReference members =
                            FirebaseFirestore.instance.collection(bcName);

                        addUser(members, name, selectedType, date);

                        // clearText();
                        Navigator.pop(context);
                      });
                    }
                  },
                  buttonText: "Register",
                  buttonColor: Color(0xff08296c),
                  txtColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
