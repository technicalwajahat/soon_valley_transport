import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:soon_valley_transport/Data/user_image_data.dart';

class UserPreferences {
  static late SharedPreferences _preferences;

  static const _keyUser = 'user';
  static const UserData myUser = UserData(imagePath: 'assets/ic_dummy.png');

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUser(UserData user) async {
    final json = jsonEncode(user.toJson());
    await _preferences.setString(_keyUser, json);
  }

  static UserData getUser() {
    final json = _preferences.getString(_keyUser);
    return json == null ? myUser : UserData.fromJson(jsonDecode(json));
  }
}
