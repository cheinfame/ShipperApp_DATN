import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _secureStorage;

  SecureStorageService({FlutterSecureStorage? secureStorage})
      : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  // Store a string value
  Future<void> setStringValue(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  // Retrieve a string value
  Future<String?> getStringValue(String key) async {
    return await _secureStorage.read(key: key);
  }

  // Store a boolean value
  Future<void> setBoolValue(String key, bool value) async {
    await _secureStorage.write(key: key, value: value.toString());
  }

  // Retrieve a boolean value
  Future<bool?> getBoolValue(String key) async {
    final value = await _secureStorage.read(key: key);
    return value != null ? value.toLowerCase() == 'true' : null;
  }

  // Store an integer value
  Future<void> setIntValue(String key, int value) async {
    await _secureStorage.write(key: key, value: value.toString());
  }

  // Retrieve an integer value
  Future<int?> getIntValue(String key) async {
    final value = await _secureStorage.read(key: key);
    return value != null ? int.tryParse(value) : null;
  }

  // Store a double value
  Future<void> setDoubleValue(String key, double value) async {
    await _secureStorage.write(key: key, value: value.toString());
  }

  // Retrieve a double value
  Future<double?> getDoubleValue(String key) async {
    final value = await _secureStorage.read(key: key);
    return value != null ? double.tryParse(value) : null;
  }

  // Remove a value
  Future<void> removeValue(String key) async {
    await _secureStorage.delete(key: key);
  }

  // Clear all values
  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }
}
