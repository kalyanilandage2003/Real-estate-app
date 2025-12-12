import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ghar_for_sale/controller/share_pref.dart';
import 'package:ghar_for_sale/util/constant.dart';
import 'package:ghar_for_sale/view/login_screen.dart';
import 'package:ghar_for_sale/widgets/custom_button.dart';
import 'package:ghar_for_sale/widgets/custom_snackbar.dart';
import 'package:ghar_for_sale/widgets/custom_textfield.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false),
        body: const TabBarView(
          children: [UserSignUpTab(), ArchitectSignUpTab()],
        ),
      ),
    );
  }
}

class UserSignUpTab extends StatefulWidget {
  const UserSignUpTab({super.key});

  @override
  State<UserSignUpTab> createState() => _UserSignUpTabState();
}

class _UserSignUpTabState extends State<UserSignUpTab> {
  bool isPasswordShown = true;
  bool isCnfmPasswordShown = true;
  bool _isLoading = false;

  ///CONTROLLERS
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cnfmPasswordController = TextEditingController();

  ///FIREBASE OBJECT
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  ///FUNCTION FOR SIGNUP
  _userSignUp() async {
    FocusScope.of(context).unfocus();
    final passwordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$',
    );

    if (passwordController.text.trim() != cnfmPasswordController.text.trim()) {
      CustomSnackbar().showCustomSnackbar(
        context,
        "Passwords do not match.",
        bgColor: red,
      );
      return;
    }

    if (!passwordRegex.hasMatch(passwordController.text.trim())) {
      CustomSnackbar().showCustomSnackbar(
        context,
        "Password must contain at least 1 capital letter, 1 small letter, 1 number , 1 symbol, and 8+ characters.",
        bgColor: red,
      );
      return;
    }
    if (emailController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      try {
        UserCredential userCredential = await _firebaseAuth
            .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            );

        /// Firestore user document
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
              'fullName': nameController.text.trim(),
              'email': emailController.text.trim(),
              'phone': '',
              'role': 'user',
              'profileImage': '',
              'favorites': [],
              'cartItems': [],
              'joinedAt': FieldValue.serverTimestamp(),
              'isBlocked': false,
            });

        /// Save role locally
        await MySharedPrefference.saveUserType('user');
        await MySharedPrefference.saveIsLogin(true);

        /// Clear fields
        nameController.clear();
        emailController.clear();
        passwordController.clear();
        cnfmPasswordController.clear();

        CustomSnackbar().showCustomSnackbar(
          context,
          "Registered Successfully!",
          bgColor: green,
        );

        goToPushReplacement(context, LoginScreen());
      } on FirebaseAuthException catch (error) {
        log(" Error Code: ${error.code}");
        log("Error Message: ${error.message}");

        if (error.code == "invalid-email") {
          CustomSnackbar().showCustomSnackbar(
            context,
            "Enter valid email id.",
            bgColor: red,
          );
        } else if (error.code == "weak-password") {
          CustomSnackbar().showCustomSnackbar(
            context,
            "Password should be at least 6 characters.",
            bgColor: red,
          );
        } else if (error.code == "email-already-in-use") {
          CustomSnackbar().showCustomSnackbar(
            context,
            "Email already registered. Try login.",
            bgColor: red,
          );
        } else {
          CustomSnackbar().showCustomSnackbar(
            context,
            error.message ?? "Signup failed",
            bgColor: red,
          );
        }
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Image.asset(height: 150, width: 150, "assets/images/applogo.png"),
          const SizedBox(height: 20),
          CustomTextField(
            controller: nameController,
            textInputAction: TextInputAction.next,
            hintText: "Enter your Name",
            prefix: const Icon(Icons.person),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: emailController,
            textInputAction: TextInputAction.next,
            hintText: "Enter your Email",
            prefix: const Icon(Icons.email),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            keyboardtype: TextInputType.text,
            controller: passwordController,
            textInputAction: TextInputAction.next,
            hintText: "Enter your Password",
            isPassword: isPasswordShown,
            prefix: const Icon(Icons.vpn_key),
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
          const SizedBox(height: 20),
          CustomTextField(
            controller: cnfmPasswordController,
            textInputAction: TextInputAction.next,
            hintText: "Confirm Password",
            isPassword: isCnfmPasswordShown,
            prefix: const Icon(Icons.lock),
            suffix: IconButton(
              onPressed: () {
                setState(() {
                  isCnfmPasswordShown = !isCnfmPasswordShown;
                });
              },
              icon: isCnfmPasswordShown
                  ? Icon(Icons.visibility_off)
                  : Icon(Icons.visibility),
            ),
          ),
          const SizedBox(height: 190),
          CustomButton(
            horizontal: 124,
            text: "Sign Up",
            isLoading: _isLoading,
            onTapped: () async {
              await _userSignUp();
            },
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already a User? ",
                style: TextStyle(fontSize: 18, color: blueGrey),
              ),
              GestureDetector(
                onTap: () => goToPushReplacement(context, LoginScreen()),
                child: Text(
                  "Login",
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
    );
  }
}

class ArchitectSignUpTab extends StatefulWidget {
  const ArchitectSignUpTab({super.key});

  @override
  State<ArchitectSignUpTab> createState() => _ArchitectSignUpTabState();
}

class _ArchitectSignUpTabState extends State<ArchitectSignUpTab> {
  bool isPasswordShown = true;
  bool isCnfmPasswordShown = true;
  bool _isLoading = false;

  ///CONTROLLERS
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cnfmPasswordController = TextEditingController();
  TextEditingController panCardController = TextEditingController();
  TextEditingController eduDegController = TextEditingController();
  TextEditingController licenseController = TextEditingController();

  ///FIREBASE OBJECT
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  ///FUNCTION FOR SIGNUP
  _architectSignUp() async {
    FocusScope.of(context).unfocus();
    final passwordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$',
    );

    if (passwordController.text.trim() != cnfmPasswordController.text.trim()) {
      CustomSnackbar().showCustomSnackbar(
        context,
        "Passwords do not match.",
        bgColor: red,
      );
      return;
    }

    if (!passwordRegex.hasMatch(passwordController.text.trim())) {
      CustomSnackbar().showCustomSnackbar(
        context,
        "Password must contain at least 1 capital letter, 1 small letter, 1 number , 1 symbol, and 8+ characters.",
        bgColor: red,
      );
      return;
    }
    if (emailController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty &&
        licenseController.text.trim().isNotEmpty &&
        panCardController.text.trim().isNotEmpty &&
        eduDegController.text.trim().isNotEmpty) {
      setState(() {
        _isLoading = true; // ✅ show loader
      });

      try {
        UserCredential userCredential = await _firebaseAuth
            .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
              'fullName': nameController.text.trim(),
              'email': emailController.text.trim(),
              'phone': '',
              'location': '',
              'bio': '',
              'availableFor': '',
              'role': 'architect',
              'licenseNo': licenseController.text.trim(),
              'panCard': panCardController.text.trim(),
              'eduDegree': eduDegController.text.trim(),
              'specialization': '', // optional
              'profileImage': '',
              'joinedAt': FieldValue.serverTimestamp(),
              'experience': 0,
              'verified': false, // admin verification
              'isBlocked': false,
            });

        await MySharedPrefference.saveUserType('architect');
        await MySharedPrefference.saveIsLogin(true);

        // Clear fields

        nameController.clear();
        emailController.clear();
        passwordController.clear();
        cnfmPasswordController.clear();
        licenseController.clear();
        panCardController.clear();
        eduDegController.clear();

        ///Pop the page
        goToPushReplacement(context, LoginScreen());

        CustomSnackbar().showCustomSnackbar(
          context,
          "Registered Successfully!",
          bgColor: green,
        );

        gotoBack(context);
      } on FirebaseAuthException catch (error) {
        log(" Error Code: ${error.code}");
        log(" Error Message: ${error.message}");

        if (error.code == "invalid-email") {
          CustomSnackbar().showCustomSnackbar(
            context,
            "Enter valid email id.",
            bgColor: red,
          );
        } else if (error.code == "weak-password") {
          CustomSnackbar().showCustomSnackbar(
            context,
            "Password should be at least 6 characters.",
            bgColor: red,
          );
        } else if (error.code == "email-already-in-use") {
          CustomSnackbar().showCustomSnackbar(
            context,
            "Email already registered. Try login.",
            bgColor: red,
          );
        } else {
          CustomSnackbar().showCustomSnackbar(
            context,
            error.message ?? "Signup failed",
            bgColor: red,
          );
        }
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Image.asset(height: 150, width: 150, "assets/logo.png"),
          const SizedBox(height: 20),
          CustomTextField(
            controller: nameController,
            textInputAction: TextInputAction.next,
            hintText: "Enter your Name",
            prefix: const Icon(Icons.person),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: emailController,
            textInputAction: TextInputAction.next,
            hintText: "Enter your Email",
            prefix: const Icon(Icons.email),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: licenseController,
            maxLength: 8,
            textInputAction: TextInputAction.next,
            hintText: "License / Registration No.",
            prefix: const Icon(Icons.badge),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: panCardController,
            textInputAction: TextInputAction.next,
            hintText: "Pan Card",
            maxLength: 8,
            prefix: const Icon(Icons.document_scanner),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: eduDegController,
            textInputAction: TextInputAction.next,
            hintText: "Educational Degree",
            prefix: const Icon(Icons.school),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: passwordController,
            textInputAction: TextInputAction.next,
            hintText: "Enter your Password",
            isPassword: isPasswordShown,
            prefix: const Icon(Icons.vpn_key),
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
          const SizedBox(height: 20),
          CustomTextField(
            controller: cnfmPasswordController,
            textInputAction: TextInputAction.next,
            hintText: "Confirm Password",
            isPassword: isCnfmPasswordShown,
            prefix: const Icon(Icons.lock),
            suffix: IconButton(
              onPressed: () {
                setState(() {
                  isCnfmPasswordShown = !isCnfmPasswordShown;
                });
              },
              icon: isCnfmPasswordShown
                  ? Icon(Icons.visibility_off)
                  : Icon(Icons.visibility),
            ),
          ),
          const SizedBox(height: 20),
          // CustomTextField(
          //   hintText: "Portfolio Link (Optional)",
          //   prefix: const Icon(Icons.link),
          // ),
          const SizedBox(height: 30),
          CustomButton(
            horizontal: 65,
            text: "Sign Up as Architect",
            isLoading: _isLoading,
            onTapped: () async {
              await _architectSignUp();
            },
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already a User? ",
                style: TextStyle(fontSize: 18, color: blueGrey),
              ),
              GestureDetector(
                onTap: () => goToPushReplacement(context, LoginScreen()),
                child: Text(
                  "Login",
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
    );
  }
}
