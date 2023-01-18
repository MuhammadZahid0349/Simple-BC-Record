import 'package:flutter/material.dart';

class CustomizedTextfield extends StatelessWidget {
  final TextEditingController myController;
  final String? hintText;
  // final bool? isPassword;

  const CustomizedTextfield(
      {Key? key, required this.myController, this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: TextFormField(
        controller: myController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please Fill this Filled';
          }
          return null;
        },
        decoration: InputDecoration(
          // errorText: ,
          // enabledBorder: OutlineInputBorder(
          //   borderSide: BorderSide(color: Colors.black, width: 1),
          //   borderRadius: BorderRadius.circular(10),
          // ),
          ////////////////////////////////
          // focusedBorder: OutlineInputBorder(
          //   borderSide: BorderSide(color: Colors.black, width: 1),
          //   borderRadius: BorderRadius.circular(10),
          // ),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          // errorText: _errorText,
        ),
      ),
    );
  }
}  //extra remove 1

//   String? get _errorText {
//     // at any time, we can get the text from _controller.value.text
//     final text = myController.value.text;
//     // Note: you can do your own custom validation here
//     // Move this logic this outside the widget for more testable code
//     if (text == null || text.isEmpty) {
//       return 'Please Enter Email';
//     } else if (!text.contains('@')) {
//       return 'Please Enter Valid Email';
//     }
//     // return null if the text is valid
//     return null;
//   }
// }
