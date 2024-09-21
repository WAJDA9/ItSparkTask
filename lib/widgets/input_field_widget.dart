import 'package:flutter/material.dart';
import 'package:itsparktask/const/colors.dart';
import 'package:itsparktask/const/text.dart';


class TextFieldWidget extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  const TextFieldWidget(
      {super.key,
      required this.hintText,
      required this.isPassword,
      required this.controller,
      this.keyboardType = TextInputType.emailAddress,
      this.validator
      });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late bool showText;
  bool showPassword = true;
  @override
  void initState() {
    showText = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
     
       TextFormField(
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          obscureText: showText && showPassword,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            filled: true,
            fillColor: AppColors.fieldsColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            hintText: widget.hintText,
            hintStyle: AppTextStyle.infoText,
            suffixIcon: widget.isPassword
                ? showPassword
                    ? IconButton(
                        icon: const Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        })
                    : IconButton(
                        icon: const Icon(Icons.visibility),
                        onPressed: () {
                         setState(() {
                            showPassword = !showPassword;
                         });
                        })
                : null,
          ),
        );
      
   
  }
}
