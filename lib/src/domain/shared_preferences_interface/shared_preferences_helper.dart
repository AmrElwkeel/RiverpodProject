abstract class SharedPreferencesHelper {
  Future<bool> saveValue(String key, dynamic value);

  dynamic getValue(String key);
  bool isValueExist(String key);
  Future<bool> removeValue(String key);

}

abstract class SharedPreferencesWriter {
  Future<bool> saveValue(String key, dynamic value);
  Future<bool> removeValue(String key);
}

abstract class SharedPreferencesReader {
  dynamic getValue(String key);
}
