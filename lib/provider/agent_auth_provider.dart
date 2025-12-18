import 'package:flutter/material.dart';
import 'package:ghar_for_sale/controller/share_pref.dart';

class AgentAuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> loginAgent({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));
    await MySharedPrefference.saveIsLogin(true);
    await MySharedPrefference.saveUserType("agent");
    await MySharedPrefference.saveUserId("AGENT_001");

    _isLoading = false;
    notifyListeners();

    return true;
  }

  Future<void> logout() async {
    await MySharedPrefference.clearPrefs();
    notifyListeners();
  }
}
