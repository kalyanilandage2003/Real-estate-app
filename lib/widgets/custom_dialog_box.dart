// import 'package:flutter/material.dart';
// import 'package:ghar_for_sale/util/constant.dart';

// void showConfirmDialog({
//   required BuildContext context,
//   required String msg, // "Log Out" or "send a request"
//   String? snackMsg, // optional message for SnackBar
//   VoidCallback? onConfirm, // optional function to perform action
// }) {
//   showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       title: const Text("Confirm Action"),
//       content: Text("Are you sure you want to $msg?"),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text("Cancel", style: TextStyle(color: grey)),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             Navigator.pop(context);
//             if (onConfirm != null) {
//               onConfirm();
//             }

//             //Show SnackBar if message exists
//             if (snackMsg != null && snackMsg.isNotEmpty) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   backgroundColor: green,
//                   behavior: SnackBarBehavior.floating,
//                   content: Text(snackMsg, style: const TextStyle(color: white)),
//                 ),
//               );
//             }
//           },
//           style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
//           child: const Text("Confirm", style: TextStyle(color: white)),
//         ),
//       ],
//     ),
//   );
// }
