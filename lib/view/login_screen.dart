import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ghar_for_sale/controller/share_pref.dart';
import 'package:ghar_for_sale/util/constant.dart';
import 'package:ghar_for_sale/view/signup_screen.dart';
import 'package:ghar_for_sale/widgets/custom_button.dart';
import 'package:ghar_for_sale/widgets/custom_snackbar.dart';
import 'package:ghar_for_sale/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordShown = true;
  bool _isLoading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  _onLogin() async {
    FocusScope.of(context).unfocus();
    if (emailController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      try {
        UserCredential userCredential = await _firebaseAuth
            .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            );

        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        final role = userDoc['role'];

        await MySharedPrefference.saveUserType(role);
        await MySharedPrefference.saveIsLogin(true);

        bool isLogin = MySharedPrefference.getIsLogin();

        if (isLogin) {
          if (role == 'user') {
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(builder: (_) => const BottomNavigationPage()),
            //   (route) => false,
            // );
          } else if (role == 'architect') {
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(builder: (_) => const ArchitectBottomPage()),
            //   (route) => false,
            // );
          } else if (role == 'admin') {
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(builder: (_) => const AdminHomeScreen()),
            //   (route) => false,
            // );
          }
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          );
        }
      } on FirebaseAuthException catch (error) {
        log(" Error Code: ${error.code}");
        log(" Error Message: ${error.message}");

        String message = switch (error.code) {
          "invalid-email" => "Enter valid email id.",
          "weak-password" => "Password should be at least 6 characters.",
          "email-already-in-use" => "Email already registered. Try login.",
          _ => error.message ?? "Login failed",
        };

        CustomSnackbar().showCustomSnackbar(context, message, bgColor: red);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      CustomSnackbar().showCustomSnackbar(
        context,
        "Enter Valid Data.",
        bgColor: red,
      );
    }
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
              Image.asset(height: 180, width: 180, "assets/images/applogo.png"),

              const SizedBox(height: 50),
              CustomTextField(
                controller: emailController,

                textInputAction: TextInputAction.next,
                hintText: "Enter your Email",
                prefix: Icon(Icons.email),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: passwordController,
                textInputAction: TextInputAction.next,
                isPassword: isPasswordShown,
                hintText: "Enter your Password",
                prefix: Icon(Icons.vpn_key),
                suffix: IconButton(
                  onPressed: () {
                    setState(() {
                      isPasswordShown = !isPasswordShown;
                    });
                  },
                  icon: isPasswordShown
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                ),
              ),
              const SizedBox(height: 5),
              // GestureDetector(
              //   onTap: () =>
              //       goToPushReplacement(context, ForgotPasswordScreen()),
              //   child: Align(
              //     alignment: Alignment.bottomRight,
              //     child: Text(
              //       "Forgot Password ?",
              //       style: TextStyle(color: blueGrey),
              //     ),
              //   ),
              // ),
              const SizedBox(height: 240),
              CustomButton(
                horizontal: 130,
                text: "Login",
                isLoading: _isLoading,
                onTapped: _onLogin,
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
                    onTap: () => goToPush(context, SignUpScreen()),
                    child: Text(
                      "Signup",
                      style: TextStyle(
                        color: homeTextColor,
                        fontSize: 18,
                        decoration: TextDecoration.underline,
                        decorationColor: homeTextColor,
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
