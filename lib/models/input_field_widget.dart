import 'package:authapp/factory/color_factory.dart';
import 'package:flutter/material.dart';

class InputFieldWidget extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final bool isPassword;
  const InputFieldWidget({
    super.key,
    required this.controller,
    this.hintText,
    this.isPassword = false,
  });

  @override
  State<InputFieldWidget> createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  bool _obsecureText = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: ColorFactory.buttonField,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText ?? '',
              ),
              style: TextStyle(color: ColorFactory.textBlack, fontSize: 16),
              obscureText: widget.isPassword ? _obsecureText : false,
              onChanged: (value) => debugPrint('Input changed: $value'),
            ),
          ),
          const SizedBox(width: 10),
          if (widget.isPassword)
            IconButton(
              onPressed: () {
                setState(() {
                  _obsecureText = !_obsecureText;
                });
              },
              icon: Icon(
                _obsecureText ? Icons.visibility_off : Icons.visibility,
                color: ColorFactory.textGray,
              ),
            ),
        ],
      ),
    );
  }
}
