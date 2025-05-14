import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'storage_provider.g.dart';

@riverpod
FlutterSecureStorage storage(StorageRef ref) {
  return const FlutterSecureStorage();
}
