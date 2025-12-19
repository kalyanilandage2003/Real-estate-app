import 'package:flutter/material.dart';
import 'package:ghar_for_sale/provider/user_auth_provider.dart';
import 'package:ghar_for_sale/util/constant.dart';
import 'package:ghar_for_sale/view/screens/bottom_navigation_screen.dart';
import 'package:ghar_for_sale/view/screens/user_signup_screen.dart';
import 'package:ghar_for_sale/widgets/custom_button.dart';
import 'package:ghar_for_sale/widgets/custom_snackbar.dart';
import 'package:ghar_for_sale/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _onLogin(BuildContext context) async {
    FocusScope.of(context).unfocus();

    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      CustomSnackbar().showCustomSnackbar(
        context,
        "Enter valid credentials",
        bgColor: red,
      );
      return;
    }

    try {
      await context.read<UserAuthProvider>().loginUser(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      // ❌ no navigation here
    } catch (e) {
      if (!mounted) return;
      CustomSnackbar().showCustomSnackbar(context, e.toString(), bgColor: red);
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    final auth = context.watch<UserAuthProvider>();

    // 🔥 AUTO NAVIGATION AFTER LOGIN
    if (auth.currentUser != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const BottomNavScreen()),
          (_) => false,
        );
      });
    }

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 80),
            Image.asset("assets/images/applogo.png", height: 180),

            const SizedBox(height: 50),
            CustomTextField(
              controller: emailController,
              hintText: "Enter your Email",
              keyboardtype: TextInputType.emailAddress,
              prefix: const Icon(Icons.email),
              isPassword: false,
            ),

            const SizedBox(height: 20),
            CustomTextField(
              controller: passwordController,
              hintText: "Enter your Password",
              keyboardtype: TextInputType.text,
              isPassword: !auth.isPasswordShown,
              prefix: const Icon(Icons.vpn_key),
              suffix: IconButton(
                onPressed: auth.togglePasswordVisibility,
                icon: Icon(
                  auth.isPasswordShown
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
              ),
            ),

            const SizedBox(height: 240),
            CustomButton(
              horizontal: 130,
              text: "Login",
              isLoading: auth.isLoading,
              onTapped: () => _onLogin(context),
              color: blueAccent,
            ),

            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Not yet Registered? ",
                  style: TextStyle(fontSize: 18, color: blueGrey),
                ),
                GestureDetector(
                  onTap: () => goToPush(context, const UserSignUpScreen()),
                  child: const Text(
                    "Signup",
                    style: TextStyle(
                      color: blue,
                      fontSize: 18,
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
