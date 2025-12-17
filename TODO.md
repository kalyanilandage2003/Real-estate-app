# TODO: Fix Login Code Errors

## Issues Identified

- [x] Password visibility logic inverted in CustomTextField
- [x] Undefined logger and request in login_screen.dart (no logger/request found in file)
- [x] Wrong image path in signup_screen.dart ArchitectSignUpTab
- [x] Redundant ternary in CustomTextField obscureText
- [x] Unnecessary gotoBack after goToPushReplacement in signup_screen.dart

## Fixes Implemented

- [x] Update CustomTextField obscureText to: obscureText: !isPassword
- [x] Change image path in ArchitectSignUpTab to "assets/images/applogo.png"
- [x] Remove gotoBack(context) after goToPushReplacement in signup_screen.dart
- [x] Ensure password starts hidden (isPasswordShown = false initially in login_screen.dart and signup_screen.dart)

## Testing

- [ ] Test login functionality
- [ ] Test password visibility toggle
- [ ] Test signup navigation
