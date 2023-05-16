import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CodeField extends StatelessWidget {
  final TextEditingController? controller;
  final bool? first, last;
  const CodeField({
    Key? key,
    this.controller,
    this.first,
    this.last,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: const BorderSide(color: Color(0xff009688)),
    );
    return TextFormField(
      controller: controller,
      showCursor: false,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.red),
      keyboardType: TextInputType.number,
      maxLength: 1,
      decoration: InputDecoration(
          isDense: true,
          counter: const Offstage(),
          // contentPadding:
          //     EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
          border: outlineInputBorder,
          enabledBorder: outlineInputBorder,
          constraints: BoxConstraints(maxWidth: 40.w)),
      onChanged: (value) {
        if (value.length == 1 && last == false) {
          FocusScope.of(context).nextFocus();
        }
        if (value.isEmpty && first == false) {
          FocusScope.of(context).previousFocus();
        }
      },
    );
  }
}
