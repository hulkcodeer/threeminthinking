import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:threeminthinking/features/splash/domain/entities/user_info_entity.dart';

part 'user_info_dto.freezed.dart';
part 'user_info_dto.g.dart';

@freezed
class UserInfoDto with _$UserInfoDto {
  const factory UserInfoDto({
    required String id,
    required String deviceId,
    required String nickname,
    required String avatarImageType,
    String? inviteCode,
    String? pushToken,
    String? coupleId,
  }) = _UserInfoDto;

  factory UserInfoDto.fromJson(Map<String, dynamic> json) => _$UserInfoDtoFromJson(json);
}

extension UserInfoDtoX on UserInfoDto {
  UserInfoEntity toEntity() => UserInfoEntity(
        id: id,
        deviceId: deviceId,
        nickname: nickname,
        avatarImageType: avatarImageType,
        inviteCode: inviteCode,
        pushToken: pushToken,
      );
}
