import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:threeminthinking/core/data/dtos/response_dto.dart';
import 'package:threeminthinking/features/splash/data/datasources/splash_supabase_data_source.dart';
import 'package:threeminthinking/features/splash/data/dtos/user_info_dto.dart';
import 'package:threeminthinking/features/splash/domain/entities/user_info_entity.dart';
import 'package:threeminthinking/features/splash/domain/repositories/splash_repository.dart';

part 'splash_repository_impl.g.dart';

class SplashRepositoryImpl implements SplashRepository {
  final SplashSupabaseDataSource _dataSource;

  SplashRepositoryImpl(
    this._dataSource,
  );

  @override
  Future<UserInfoEntity?> getLocalUserInfo() async {
    return _dataSource.getLocalUserInfo();
  }

  @override
  Future<ResponseDto<UserInfoDto>> getUserInfoByDeviceId(String deviceId) async {
    return _dataSource.getUserInfoByDeviceId(deviceId);
  }

  @override
  Future<void> saveUserInfo(UserInfoEntity userInfo) async {
    return _dataSource.saveUserInfo(userInfo);
  }
}

@riverpod
SplashRepositoryImpl splashRepository(Ref ref) {
  return SplashRepositoryImpl(
    ref.watch(splashSupabaseDataSourceProvider),
  );
}
