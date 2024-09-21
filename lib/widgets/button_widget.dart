import 'package:flutter/material.dart';
import 'package:itsparktask/const/colors.dart';
import 'package:itsparktask/const/text.dart';


class ButtonWidget extends StatefulWidget {
  final String buttonText;
  final VoidCallback? onClick;
  const ButtonWidget(
      {super.key, required this.buttonText, required this.onClick});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onClick,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        widget.buttonText,
        style: AppTextStyle.buttonText,
      ),
    );
  }
}
