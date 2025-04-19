import 'package:flutter/material.dart';
import 'package:tip_calculator/core/constants/app_theme/app_colors.dart';
import 'package:tip_calculator/core/constants/utils/textfield_hight.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _hasInteracted = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:
          TextfieldHight.textfieldHeight +
          16, 
      child: TextFormField(
        
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        decoration: InputDecoration(
          label: Text(widget.labelText),

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: MyColors.primaryColor,
              width: 2,
            ),
          ),
          prefixIcon: Icon(widget.prefixIcon, color: MyColors.primaryColor),
          errorStyle: const TextStyle(
            fontSize: 12,
            height: 1.0, 
          ),
          errorMaxLines: 1,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 12,
          ),
        ),
        validator: widget.validator,
        onChanged: (value) {
          setState(() {
            _hasInteracted = true; 
          });
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
        autovalidateMode:
            _hasInteracted
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
