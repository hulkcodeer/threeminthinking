import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:threeminthinking/core/data/datasources/secure_storage_data_source.dart';
import 'package:threeminthinking/core/data/dtos/response_dto.dart';
import 'package:threeminthinking/core/providers/supabase_provider.dart';
import 'package:threeminthinking/features/splash/data/dtos/user_info_dto.dart';
import 'package:threeminthinking/features/splash/domain/entities/user_info_entity.dart';

part 'splash_supabase_data_source.g.dart';

class SplashSupabaseDataSource {
  final SupabaseClient _client;
  final SecureStorageDataSource _secureStorage;
  static const USER_KEY = 'user_data';

  SplashSupabaseDataSource(this._client, this._secureStorage);

  Future<UserInfoEntity?> getLocalUserInfo() async {
    final data = await _secureStorage.getJsonData(USER_KEY);
    if (data != null) {
      return UserInfoEntity.fromJson(data);
    }
    return null;
  }

  Future<void> saveUserInfo(UserInfoEntity userInfo) async {
    await _secureStorage.saveJsonData(USER_KEY, userInfo.toJson());
  }

  Future<ResponseDto<UserInfoDto>> getUserInfoByDeviceId(String deviceId) async {
    try {
      final existingDevice = await _client.from('devices').select('user_id').eq('device_id', deviceId).maybeSingle();

      if (existingDevice != null) {
        return ResponseDto(
          success: true,
          data: UserInfoDto(
            id: existingDevice['user_id'],
            deviceId: deviceId,
          ),
        );
      } else {
        final newUser = await _client
            .from('users')
            .insert({
              'email': null, // 나중에 업데이트
              'username': 'Anonymous User'
            })
            .select()
            .single();

        await _client.from('devices').insert({
          'user_id': newUser['id'],
          'device_id': deviceId,
          'device_type': Platform.isIOS ? 'ios' : 'android',
          'is_primary': true
        });

        return ResponseDto(
          success: true,
          data: UserInfoDto(
            id: newUser['id'],
            deviceId: deviceId,
          ),
        );
      }
    } catch (e) {
      print('UserInfoSupabaseDataSource error: $e');
      return const ResponseDto(
        success: false,
        message: 'Server Error',
      );
    }
  }
}

@riverpod
SplashSupabaseDataSource splashSupabaseDataSource(Ref ref) {
  return SplashSupabaseDataSource(ref.watch(supabaseProvider), ref.watch(secureStorageProvider));
}
