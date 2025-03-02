import 'package:shared_preferences/shared_preferences.dart';
import '../core/errors/exceptions.dart';

class LocalStorageService {
  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  Future<void> saveData<T>(String key, T value) async {
    try {
      if (value is String) {
        await _prefs.setString(key, value);
      } else if (value is int) {
        await _prefs.setInt(key, value);
      } else if (value is bool) {
        await _prefs.setBool(key, value);
      } else {
        throw CacheException('Unsupported data type');
      }
    } catch (e) {
      throw CacheException('Failed to save data: $e');
    }
  }

  dynamic getData(String key) {
    try {
      return _prefs.get(key);
    } catch (e) {
      throw CacheException('Failed to retrieve data: $e');
    }
  }

  Future<void> removeData(String key) async {
    try {
      await _prefs.remove(key);
    } catch (e) {
      throw CacheException('Failed to remove data: $e');
    }
  }

  Future<void> clearAll() async {
    try {
      await _prefs.clear();
    } catch (e) {
      throw CacheException('Failed to clear storage: $e');
    }
  }
}