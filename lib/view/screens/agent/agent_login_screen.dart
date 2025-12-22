// import 'package:flutter/material.dart';
// import 'package:ghar_for_sale/agent/dashboard_screen.dart';
// import 'package:ghar_for_sale/provider/agent_auth_provider.dart';
// import 'package:ghar_for_sale/util/constant.dart';
// import 'package:ghar_for_sale/view/screens/agent/agent_signup_screen.dart';
// import 'package:ghar_for_sale/widgets/custom_button.dart';
// import 'package:ghar_for_sale/widgets/custom_snackbar.dart';
// import 'package:ghar_for_sale/widgets/custom_textfield.dart';
// import 'package:provider/provider.dart';

// class AgentLoginScreen extends StatefulWidget {
//   const AgentLoginScreen({super.key});

//   @override
//   State createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State {
//   bool isPasswordShown = false;

//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   Future<void> _onLogin() async {
//     FocusScope.of(context).unfocus();

//     if (emailController.text.trim().isEmpty ||
//         passwordController.text.trim().isEmpty) {
//       CustomSnackbar().showCustomSnackbar(
//         context,
//         "Enter Valid Data.",
//         bgColor: red,
//       );
//       return;
//     }

//     final authProvider = context.read<AgentAuthProvider>();

//     final success = await authProvider.loginAgent(
//       email: emailController.text.trim(),
//       password: passwordController.text.trim(),
//     );

//     if (success && mounted) {
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (_) => const DashboardScreen()),
//         (_) => false,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authProvider = context.watch<AgentAuthProvider>();

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             children: [
//               const SizedBox(height: 80),
//               Image.asset("assets/images/applogo.png", height: 180),

//               const SizedBox(height: 50),
//               CustomTextField(
//                 controller: emailController,
//                 textInputAction: TextInputAction.next,
//                 hintText: "Enter your Email",
//                 prefix: const Icon(Icons.email),
//               ),

//               const SizedBox(height: 20),
//               CustomTextField(
//                 controller: passwordController,
//                 textInputAction: TextInputAction.done,
//                 isPassword: isPasswordShown,
//                 hintText: "Enter your Password",
//                 prefix: const Icon(Icons.vpn_key),
//                 suffix: IconButton(
//                   onPressed: () {
//                     setState(() {
//                       isPasswordShown = !isPasswordShown;
//                     });
//                   },
//                   icon: Icon(
//                     isPasswordShown ? Icons.visibility_off : Icons.visibility,
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 240),
//               CustomButton(
//                 horizontal: 130,
//                 text: "Login",
//                 isLoading: authProvider.isLoading,
//                 onTapped: _onLogin,
//                 color: blueAccent,
//               ),

//               const SizedBox(height: 15),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Not yet Registered? ",
//                     style: TextStyle(fontSize: 18, color: blueGrey),
//                   ),
//                   GestureDetector(
//                     onTap: () => goToPush(context, AgentSignUpScreen()),
//                     child: Text(
//                       "Signup",
//                       style: TextStyle(
//                         color: blue,
//                         fontSize: 18,
//                         decoration: TextDecoration.underline,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
