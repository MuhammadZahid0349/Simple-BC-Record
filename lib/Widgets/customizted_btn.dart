import 'package:flutter/material.dart';

class CustomizedBtn extends StatelessWidget {
  final String? buttonText;
  final Color? buttonColor;
  final Color? txtColor;
  // final Function? onPressed;
  final VoidCallback onPressed;

  const CustomizedBtn(
      {Key? key,
      this.buttonText,
      this.buttonColor,
      required this.onPressed,
      this.txtColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: buttonColor,
            border: Border.all(width: 1, color: Colors.blue),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              buttonText!,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: txtColor),
            ),
          ),
        ),
      ),
    );
  }
}
