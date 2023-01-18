import 'package:bc_info/Widgets/customizted_btn.dart';
import 'package:bc_info/firebase/Data%20CRUD/change_passwordfb.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();

  var newPassword = "";

  final _newPasswordController = TextEditingController();

  @override
  void dispose() {
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: TextFormField(
              enableSuggestions: true,
              obscureText: true,
              controller: _newPasswordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter New Password';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Enter New Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: CustomizedBtn(
              buttonText: "Change Password",
              buttonColor: Color(0xff08296c),
              txtColor: Colors.white,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    newPassword = _newPasswordController.text;
                  });
                  changePassword(context, newPassword);
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (_) => LoginScreen()));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
