// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:ghar_for_sale/controller/share_pref.dart';
// import 'package:ghar_for_sale/util/constant.dart';
// import 'package:ghar_for_sale/view/screens/bottom_navigation_screen.dart';
// import 'package:ghar_for_sale/view/screens/signup_screen.dart';
// import 'package:ghar_for_sale/widgets/custom_button.dart';
// import 'package:ghar_for_sale/widgets/custom_snackbar.dart';
// import 'package:ghar_for_sale/widgets/custom_textfield.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   bool isPasswordShown = false;
//   bool _isLoading = false;

//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   _onLogin() async {
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

//     setState(() => _isLoading = true);

//     try {
//       UserCredential userCredential = await _firebaseAuth
//           .signInWithEmailAndPassword(
//             email: emailController.text.trim(),
//             password: passwordController.text.trim(),
//           );

//       final uid = userCredential.user!.uid;

//       final userDoc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(uid)
//           .get();

//       /// 🔴 VERY IMPORTANT CHECK
//       if (!userDoc.exists) {
//         await FirebaseFirestore.instance.collection('users').doc(uid).set({
//           'email': userCredential.user!.email,
//           'role': 'user',
//           'joinedAt': FieldValue.serverTimestamp(),
//           'isBlocked': false,
//         });
//       }

//       final data = userDoc.data()!;
//       final role = data['role'] ?? 'user';

//       await MySharedPrefference.saveUserType(role);
//       await MySharedPrefference.saveIsLogin(true);

//       /// ✅ DIRECT NAVIGATION
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (_) => const BottomNavScreen()),
//         (route) => false,
//       );
//     } on FirebaseAuthException catch (error) {
//       String message = error.message ?? "Login failed";
//       CustomSnackbar().showCustomSnackbar(context, message, bgColor: red);
//     } catch (e) {
//       CustomSnackbar().showCustomSnackbar(
//         context,
//         "Something went wrong",
//         bgColor: red,
//       );
//     } finally {
//       setState(() => _isLoading = false);
//       log("USER UID: ${FirebaseAuth.instance.currentUser?.uid}");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(height: 80),
//               Image.asset(height: 180, width: 180, "assets/images/applogo.png"),

//               const SizedBox(height: 50),
//               CustomTextField(
//                 controller: emailController,

//                 textInputAction: TextInputAction.next,
//                 hintText: "Enter your Email",
//                 prefix: Icon(Icons.email),
//               ),
//               const SizedBox(height: 20),
//               CustomTextField(
//                 controller: passwordController,
//                 textInputAction: TextInputAction.next,
//                 isPassword: isPasswordShown,
//                 hintText: "Enter your Password",
//                 prefix: Icon(Icons.vpn_key),
//                 suffix: IconButton(
//                   onPressed: () {
//                     setState(() {
//                       isPasswordShown = !isPasswordShown;
//                     });
//                   },
//                   icon: isPasswordShown
//                       ? Icon(Icons.visibility_off)
//                       : Icon(Icons.visibility),
//                 ),
//               ),
//               const SizedBox(height: 5),
//               // GestureDetector(
//               //   onTap: () =>
//               //       goToPushReplacement(context, ForgotPasswordScreen()),
//               //   child: Align(
//               //     alignment: Alignment.bottomRight,
//               //     child: Text(
//               //       "Forgot Password ?",
//               //       style: TextStyle(color: blueGrey),
//               //     ),
//               //   ),
//               // ),
//               const SizedBox(height: 240),
//               CustomButton(
//                 horizontal: 130,
//                 text: "Login",
//                 isLoading: _isLoading,
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
//                     onTap: () => goToPush(context, SignUpScreen()),
//                     child: Text(
//                       "Signup",
//                       style: TextStyle(
//                         color: blue,
//                         fontSize: 18,
//                         decoration: TextDecoration.underline,
//                         decorationColor: blue,
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
import 'package:flutter/material.dart';
import 'package:ghar_for_sale/util/constant.dart';
import 'package:ghar_for_sale/view/screens/bottom_navigation_screen.dart';
import 'package:ghar_for_sale/view/screens/signup_screen.dart';
import 'package:ghar_for_sale/widgets/custom_button.dart';
import 'package:ghar_for_sale/widgets/custom_snackbar.dart';
import 'package:ghar_for_sale/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordShown = false;
  bool _isLoading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _onLogin() async {
    FocusScope.of(context).unfocus();

    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      CustomSnackbar().showCustomSnackbar(
        context,
        "Enter Valid Data.",
        bgColor: red,
      );
      return;
    }

    setState(() => _isLoading = true);

    // ⏳ Fake delay just for loader effect (optional)
    await Future.delayed(const Duration(seconds: 1));

    setState(() => _isLoading = false);

    /// ✅ DIRECT NAVIGATION (NO FUNCTIONALITY)
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const BottomNavScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              Image.asset("assets/images/applogo.png", height: 180, width: 180),

              const SizedBox(height: 50),
              CustomTextField(
                controller: emailController,
                textInputAction: TextInputAction.next,
                hintText: "Enter your Email",
                prefix: const Icon(Icons.email),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: passwordController,
                textInputAction: TextInputAction.done,
                isPassword: isPasswordShown,
                hintText: "Enter your Password",
                prefix: const Icon(Icons.vpn_key),
                suffix: IconButton(
                  onPressed: () {
                    setState(() {
                      isPasswordShown = !isPasswordShown;
                    });
                  },
                  icon: Icon(
                    isPasswordShown ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),

              const SizedBox(height: 240),
              CustomButton(
                horizontal: 130,
                text: "Login",
                isLoading: _isLoading,
                onTapped: _onLogin,
                color: blueAccent,
              ),

              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not yet Registered? ",
                    style: TextStyle(fontSize: 18, color: blueGrey),
                  ),
                  GestureDetector(
                    onTap: () => goToPush(context, const SignUpScreen()),
                    child: Text(
                      "Signup",
                      style: TextStyle(
                        color: blue,
                        fontSize: 18,
                        decoration: TextDecoration.underline,
                        decorationColor: blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
