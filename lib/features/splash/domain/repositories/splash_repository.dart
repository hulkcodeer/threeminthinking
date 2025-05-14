import 'package:threeminthinking/core/data/dtos/response_dto.dart';
import 'package:threeminthinking/features/splash/data/dtos/user_info_dto.dart';
import 'package:threeminthinking/features/splash/domain/entities/user_info_entity.dart';

abstract class SplashRepository {
  Future<UserInfoEntity?> getLocalUserInfo();
  Future<ResponseDto<UserInfoDto>> getUserInfoByDeviceId(String deviceId);
  Future<void> saveUserInfo(UserInfoEntity userInfo);
}
