import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final Color? borderColor;

  const CustomButtom({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.color,
    required this.textColor,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.07;

    return InkWell(
        onTap: onPressed,
        child: Container(
          height: height,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: borderColor ?? Colors.orange, width: 1.5),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
              ),
            ),
          ),
        ));
  }
}
