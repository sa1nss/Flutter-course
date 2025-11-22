import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/profile.dart';

class LocalStorageService {
  static const String key = 'profiles';

  Future<void> saveProfiles(List<Profile> profiles) async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> jsonList =
        profiles.map((p) => jsonEncode(p.toJson())).toList();

    await prefs.setStringList(key, jsonList);
  }

  Future<List<Profile>> loadProfiles() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonList = prefs.getStringList(key);

    if (jsonList == null) return [];

    return jsonList
        .map((str) => Profile.fromJson(jsonDecode(str)))
        .toList();
  }
}
