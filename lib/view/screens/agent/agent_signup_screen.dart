import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ghar_for_sale/controller/share_pref.dart';
import 'package:ghar_for_sale/util/constant.dart';
import 'package:ghar_for_sale/view/screens/agent/agent_login_screen.dart';
import 'package:ghar_for_sale/widgets/custom_button.dart';
import 'package:ghar_for_sale/widgets/custom_snackbar.dart';
import 'package:ghar_for_sale/widgets/custom_textfield.dart';

class AgentSignUpScreen extends StatefulWidget {
  const AgentSignUpScreen({super.key});

  @override
  State<AgentSignUpScreen> createState() => _AgentSignUpScreenState();
}

class _AgentSignUpScreenState extends State<AgentSignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cnfmPasswordController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final ValueNotifier<bool> isPasswordShown = ValueNotifier(true);
  final ValueNotifier<bool> isCnfmPasswordShown = ValueNotifier(true);
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  _agentSignUp() async {
    FocusScope.of(context).unfocus();

    if (passwordController.text.trim() != cnfmPasswordController.text.trim()) {
      CustomSnackbar().showCustomSnackbar(
        context,
        "Passwords do not match.",
        bgColor: red,
      );
      return;
    }

    if (nameController.text.trim().isNotEmpty &&
        emailController.text.trim().isNotEmpty &&
        phoneController.text.trim().isNotEmpty &&
        locationController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty) {
      isLoading.value = true;

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
              'phone': phoneController.text.trim(),
              'location': locationController.text.trim(),
              'role': 'agent',
              'joinedAt': FieldValue.serverTimestamp(),
              'verified': false,
              'isBlocked': false,
              'profileImage': '',
              'bio': '',
            });

        await MySharedPrefference.saveUserType('agent');
        await MySharedPrefference.saveIsLogin(true);

        goToPushReplacement(context, const AgentLoginScreen());
        CustomSnackbar().showCustomSnackbar(
          context,
          "Registered Successfully!",
          bgColor: green,
        );
      } catch (e) {
        CustomSnackbar().showCustomSnackbar(
          context,
          e.toString(),
          bgColor: red,
        );
      } finally {
        isLoading.value = false;
      }
    } else {
      CustomSnackbar().showCustomSnackbar(
        context,
        "Enter valid data",
        bgColor: red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Image.asset(height: 150, width: 150, "assets/images/applogo.png"),
            const SizedBox(height: 20),
            CustomTextField(
              controller: nameController,
              hintText: "Enter your Name",
              prefix: const Icon(Icons.person),
              isPassword: false,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: emailController,
              hintText: "Enter your Email",
              prefix: const Icon(Icons.email),
              isPassword: false,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: phoneController,
              hintText: "Phone Number",
              prefix: const Icon(Icons.phone),
              keyboardtype: TextInputType.phone,
              isPassword: false,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: locationController,
              hintText: "Location",
              prefix: const Icon(Icons.location_city),
              isPassword: false,
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder<bool>(
              valueListenable: isPasswordShown,
              builder: (_, value, __) => CustomTextField(
                controller: passwordController,
                hintText: "Enter your Password",
                isPassword: value,
                prefix: const Icon(Icons.vpn_key),
                suffix: IconButton(
                  onPressed: () => isPasswordShown.value = !value,
                  icon: Icon(value ? Icons.visibility_off : Icons.visibility),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder<bool>(
              valueListenable: isCnfmPasswordShown,
              builder: (_, value, __) => CustomTextField(
                controller: cnfmPasswordController,
                hintText: "Confirm Password",
                isPassword: value,
                prefix: const Icon(Icons.lock),
                suffix: IconButton(
                  onPressed: () => isCnfmPasswordShown.value = !value,
                  icon: Icon(value ? Icons.visibility_off : Icons.visibility),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ValueListenableBuilder<bool>(
              valueListenable: isLoading,
              builder: (_, value, __) => CustomButton(
                horizontal: 65,
                text: "Sign Up as Agent",
                isLoading: value,
                onTapped: _agentSignUp,
                color: blueAccent,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already registered? ",
                  style: TextStyle(fontSize: 16, color: blueGrey),
                ),
                GestureDetector(
                  onTap: () =>
                      goToPushReplacement(context, const AgentLoginScreen()),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: blueAccent,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
