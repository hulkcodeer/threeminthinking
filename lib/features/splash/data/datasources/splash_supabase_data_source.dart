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
      // 간소화된 쿼리로 사용자 기본 정보만 조회
      final response = await _client
          .from('users')
          .select('id, deviceId, nickname, avatarImageType, inviteCode, coupleId')
          .eq('deviceId', deviceId)
          .maybeSingle();

      // 사용자가 없는 경우
      if (response == null) {
        return const ResponseDto(
          success: false,
          message: 'User not found',
        );
      }

      // 사용자 정보만 반환
      return ResponseDto(
        success: true,
        data: UserInfoDto(
          id: response['id'],
          deviceId: response['deviceId'],
          nickname: response['nickname'],
          avatarImageType: response['avatarImageType'],
          inviteCode: response['inviteCode'],
          coupleId: response['coupleId'],
        ),
      );
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
