import '../../features/shared/models/app_models.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppSession {
  AppSession._();

  static final AppSession instance = AppSession._();
  static const String _tokenKey = 'app_session_token';
  static const String _profileKey = 'app_session_profile';

  String? token;
  SessionProfile? profile;

  bool get isLoggedIn => token != null && profile != null;
  String get initialRoute {
    if (!isLoggedIn) {
      return '/';
    }
    switch (profile!.role) {
      case UserRole.supplier:
        return '/supplier-home';
      case UserRole.werka:
        return '/werka-home';
      case UserRole.admin:
        return '/admin-home';
    }
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final storedToken = prefs.getString(_tokenKey);
    final storedProfile = prefs.getString(_profileKey);
    if (storedToken == null ||
        storedToken.isEmpty ||
        storedProfile == null ||
        storedProfile.isEmpty) {
      return;
    }
    token = storedToken;
    profile = SessionProfile.fromJson(
      jsonDecode(storedProfile) as Map<String, dynamic>,
    );
  }

  Future<void> setSession({
    required String token,
    required SessionProfile profile,
  }) async {
    this.token = token;
    this.profile = profile;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_profileKey, jsonEncode(profile.toJson()));
  }

  Future<void> clear() async {
    token = null;
    profile = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_profileKey);
  }

  Future<void> updateProfile(SessionProfile nextProfile) async {
    profile = nextProfile;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_profileKey, jsonEncode(nextProfile.toJson()));
  }
}
