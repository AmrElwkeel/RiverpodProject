
import 'package:riverpod_project/src/domain/shared_preferences_interface/shared_preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelperImpl implements SharedPreferencesHelper {
  static  SharedPreferences? _preferences;

  SharedPreferencesHelperImpl() {
     init();
  }

     Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  @override
  Future<bool> saveValue(String key, dynamic value) async {
    if (value is String) {
      return _preferences!.setString(key, value);
    } else if (value is int) {
      return _preferences!.setInt(key, value);
    } else if (value is double) {
      return _preferences!.setDouble(key, value);
    } else if (value is bool) {
      return _preferences!.setBool(key, value);
    } else {
      return false;
    }
  }

  @override
  dynamic getValue(String key) {
    return _preferences?.get(key);
  }

  @override
  Future<bool> removeValue(String key) {

    return _preferences!.remove(key);

  }
  @override
  bool isValueExist(String key) {

    return _preferences!.containsKey(key);
  }
}
