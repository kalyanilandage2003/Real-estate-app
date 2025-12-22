// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:ghar_for_sale/controller/property_controllers.dart';
// import 'package:ghar_for_sale/util/constant.dart';
// import 'package:ghar_for_sale/view/screens/login_view.dart';
// import 'package:ghar_for_sale/widgets/custom_button.dart';
// import 'package:ghar_for_sale/widgets/custom_snackbar.dart';
// import 'package:ghar_for_sale/widgets/custom_textfield.dart';

// class UserSignUpScreen extends StatefulWidget {
//   const UserSignUpScreen({super.key});

//   @override
//   State<UserSignUpScreen> createState() => _UserSignUpScreenState();
// }

// class _UserSignUpScreenState extends State<UserSignUpScreen> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController cnfmPasswordController = TextEditingController();

//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   // ValueNotifiers for password visibility & loading
//   final ValueNotifier<bool> isPasswordShown = ValueNotifier(false);
//   final ValueNotifier<bool> isCnfmPasswordShown = ValueNotifier(false);
//   final ValueNotifier<bool> isLoading = ValueNotifier(false);

//   _userSignUp() async {
//     FocusScope.of(context).unfocus();

//     if (passwordController.text.trim() != cnfmPasswordController.text.trim()) {
//       CustomSnackbar().showCustomSnackbar(
//         context,
//         "Passwords do not match.",
//         bgColor: red,
//       );
//       return;
//     }

//     if (emailController.text.trim().isNotEmpty &&
//         passwordController.text.trim().isNotEmpty) {
//       isLoading.value = true;

//       try {
//         UserCredential userCredential = await _firebaseAuth
//             .createUserWithEmailAndPassword(
//               email: emailController.text.trim(),
//               password: passwordController.text.trim(),
//             );

//         await FirebaseFirestore.instance
//             .collection('users')
//             .doc(userCredential.user!.uid)
//             .set({
//               'fullName': nameController.text.trim(),
//               'email': emailController.text.trim(),
//               'role': 'user',
//               'joinedAt': FieldValue.serverTimestamp(),
//             });

//         await MySharedPrefference.saveUserType('user');
//         await MySharedPrefference.saveIsLogin(true);

//         goToPushReplacement(context, UserLoginScreen());
//         CustomSnackbar().showCustomSnackbar(
//           context,
//           "Registered Successfully!",
//           bgColor: green,
//         );
//       } catch (e) {
//         CustomSnackbar().showCustomSnackbar(
//           context,
//           e.toString(),
//           bgColor: red,
//         );
//       } finally {
//         isLoading.value = false;
//       }
//     } else {
//       CustomSnackbar().showCustomSnackbar(
//         context,
//         "Enter valid data",
//         bgColor: red,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             SizedBox(height: 80),
//             Image.asset(height: 150, width: 150, "assets/images/applogo.png"),
//             const SizedBox(height: 20),
//             CustomTextField(
//               controller: nameController,
//               hintText: "Enter your Name",
//               prefix: const Icon(Icons.person),
//             ),
//             const SizedBox(height: 20),
//             CustomTextField(
//               controller: emailController,
//               hintText: "Enter your Email",
//               prefix: const Icon(Icons.email),
//             ),
//             const SizedBox(height: 20),
//             ValueListenableBuilder<bool>(
//               valueListenable: isPasswordShown,
//               builder: (_, value, __) => CustomTextField(
//                 controller: passwordController,
//                 hintText: "Enter your Password",
//                 isPassword: value,
//                 prefix: const Icon(Icons.vpn_key),
//                 suffix: IconButton(
//                   onPressed: () => isPasswordShown.value = !value,
//                   icon: Icon(value ? Icons.visibility_off : Icons.visibility),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ValueListenableBuilder<bool>(
//               valueListenable: isCnfmPasswordShown,
//               builder: (_, value, __) => CustomTextField(
//                 controller: cnfmPasswordController,
//                 hintText: "Confirm Password",
//                 isPassword: value,
//                 prefix: const Icon(Icons.lock),
//                 suffix: IconButton(
//                   onPressed: () => isCnfmPasswordShown.value = !value,
//                   icon: Icon(value ? Icons.visibility_off : Icons.visibility),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 50),
//             ValueListenableBuilder<bool>(
//               valueListenable: isLoading,
//               builder: (_, value, __) => CustomButton(
//                 horizontal: 124,
//                 text: "Sign Up",
//                 isLoading: value,
//                 onTapped: _userSignUp,
//                 color: blueAccent,
//               ),
//             ),
//             const SizedBox(height: 15),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   "Already a User? ",
//                   style: TextStyle(fontSize: 18, color: blueGrey),
//                 ),
//                 GestureDetector(
//                   onTap: () => goToPushReplacement(context, UserLoginScreen()),
//                   child: const Text(
//                     "Login",
//                     style: TextStyle(
//                       color: blueAccent,
//                       fontSize: 18,
//                       decoration: TextDecoration.underline,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
