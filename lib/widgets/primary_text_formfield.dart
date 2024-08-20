
import 'package:flutter/material.dart';

import '../manager/color_manager.dart';

class PrimaryTextFormField extends StatefulWidget {
  const PrimaryTextFormField({
    super.key,
    required this.controller,
    required this.hint, this.obscure,
  });

  final TextEditingController controller;
  final String hint;
  final bool? obscure;

  @override
  State<PrimaryTextFormField> createState() => _PrimaryTextFormFieldState();
}

class _PrimaryTextFormFieldState extends State<PrimaryTextFormField> {

  bool show=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText:widget.obscure!=null&&widget.obscure==true? !show:false,
      controller: widget.controller,
      
      decoration: InputDecoration(
        suffixIcon:widget.obscure!=null&&widget.obscure==true? GestureDetector(
          onTap: () {
            setState(() {
              show=!show;
            });
          },
          child: Icon(show?Icons.visibility_off:Icons.visibility)):null,
        labelText: widget.hint,
        filled: true,
        fillColor: appColors.primary.withOpacity(0.2),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                const BorderSide(color: Colors.red)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(color: appColors.primary)),
      ),
      
      validator: (value) {
        if (value == null || value == '') {
          return 'This field is required';
        }
        return null;
      },
    );
  }
}
