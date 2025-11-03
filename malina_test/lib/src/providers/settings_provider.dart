import 'package:flutter/foundation.dart';
// import 'package:malina/src/providers/auth_provider.dart';
// import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SettingsProvider with ChangeNotifier {
  Map<String, dynamic> _settings = {
    'theme': 'light',
    'notifications': true,
    'language': 'ru',
  };

  Map<String, dynamic> get settings => _settings;

  Future<void> loadSettings(String username) async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString('users') ?? '{}';
    final users = Map<String, dynamic>.from(jsonDecode(usersJson));
    final userSettings = users[username]?['settings'] ?? {};
    _settings = userSettings;
    notifyListeners();
  }

  Future<void> updateSetting(String key, dynamic value, String username) async {
    _settings[key] = value;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString('users') ?? '{}';
    final users = Map<String, dynamic>.from(jsonDecode(usersJson));
    if (users[username] != null) {
      users[username]['settings'] = _settings;
      await prefs.setString('users', jsonEncode(users));
    }
  }
}
