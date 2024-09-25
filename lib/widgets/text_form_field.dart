import 'package:flutter/material.dart';

class ETTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;

  const ETTextFormField(
      {super.key,
      required this.label,
      this.controller,
      this.obscureText = false,
      this.keyboardType = TextInputType.text,
      this.validator,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        suffixIcon: suffixIcon,
      ),
      style: const TextStyle(fontSize: 14),
    );
  } 
}