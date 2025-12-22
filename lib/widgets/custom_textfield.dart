// import 'package:flutter/material.dart';
// import 'package:ghar_for_sale/util/constant.dart';

// class CustomTextField extends StatelessWidget {
//   final String? hintText;
//   final TextEditingController? controller;
//   final int? maxLines;
//   final int? maxLength;
//   final bool isPassword;
//   final bool obscureText;
//   final bool enable;
//   final TextInputType? keyboardtype;
//   final TextInputAction? textInputAction;
//   final FocusNode? focusNode;
//   final Widget? prefix;
//   final Widget? suffix;
//   final bool readOnly;

//   const CustomTextField({
//     super.key,
//     this.controller,
//     this.enable = true,
//     this.readOnly = false,
//     this.focusNode,
//     this.hintText,
//     this.isPassword = false,
//     this.keyboardtype,
//     this.maxLines,
//     this.maxLength,
//     this.prefix,
//     this.suffix,
//     this.textInputAction,
//     this.obscureText = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 50,
//       child: TextField(
//         enabled: enable == true ? true : enable,
//         maxLines: maxLines ?? 1,
//         readOnly: readOnly,
//         focusNode: focusNode,
//         textInputAction: textInputAction,
//         keyboardType: keyboardtype ?? TextInputType.name,
//         controller: controller,
//         obscureText: isPassword,
//         maxLength: maxLength,
//         decoration: InputDecoration(
//           prefixIcon: prefix,
//           suffixIcon: suffix,
//           hintText: hintText ?? "hint text..",
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//             borderSide: BorderSide(style: BorderStyle.solid, color: blue),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//             borderSide: BorderSide(
//               style: BorderStyle.solid,
//               color: enabledBorder,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
