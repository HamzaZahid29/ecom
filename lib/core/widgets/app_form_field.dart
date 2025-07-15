import 'package:flutter/material.dart';

class AppFormField extends StatelessWidget {
  String title;
  IconData icon;
  bool isObsecured;
  VoidCallback? onTap;
  TextEditingController textEditingController;
  String? Function(String?)? validator;

  AppFormField({
    super.key,
    required this.title,
    required this.icon,
    this.isObsecured = false,
    this.onTap = null,
    required this.textEditingController,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: textEditingController,
      obscureText: isObsecured,
      decoration: InputDecoration(
        label: Text(title),
        suffixIcon: GestureDetector(onTap: onTap, child: Icon(icon, size: 16)),
      ),
    );
  }
}
