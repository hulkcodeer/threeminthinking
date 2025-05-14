import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_storage_data_source.g.dart';

class SecureStorageDataSource {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  static const USER_KEY = 'user_data';

  SecureStorageDataSource();

  Future<void> saveJsonData(String key, Map<String, dynamic> data) async {
    await _storage.write(
      key: key,
      value: jsonEncode(data),
    );
  }

  Future<Map<String, dynamic>?> getJsonData(String key) async {
    final data = await _storage.read(key: key);
    if (data != null) {
      return jsonDecode(data) as Map<String, dynamic>;
    }
    return null;
  }

  Future<void> saveData(String key, String data) async {
    await _storage.write(
      key: key,
      value: data,
    );
  }

  Future<String?> getDataString(String key) async {
    final data = await _storage.read(key: key);
    if (data != null) {
      return data;
    }
    return null;
  }

  Future<int?> getDataInt(String key) async {
    final data = await _storage.read(key: key);
    if (data != null) {
      return int.parse(data);
    }
    return null;
  }

  Future<void> deleteData(String key) async {
    await _storage.delete(key: key);
  }
}

@riverpod
SecureStorageDataSource secureStorage(Ref ref) {
  return SecureStorageDataSource();
}
