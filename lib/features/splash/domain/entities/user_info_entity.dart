import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info_entity.freezed.dart';
part 'user_info_entity.g.dart';

@freezed
class UserInfoEntity with _$UserInfoEntity {
  const factory UserInfoEntity({
    required String id,
    required String deviceId,
    required String nickname,
    required String avatarImageType,
    String? inviteCode,
    String? pushToken,
  }) = _UserInfoEntity;

  factory UserInfoEntity.empty() => const UserInfoEntity(
        id: '',
        deviceId: '',
        nickname: '',
        avatarImageType: '',
      );

  factory UserInfoEntity.fromJson(Map<String, dynamic> json) => UserInfoEntity(
        id: json['id'] as String,
        deviceId: json['deviceId'] as String,
        nickname: json['nickname'] as String,
        avatarImageType: json['avatarImageType'] as String,
        inviteCode: json['inviteCode'] as String?,
        pushToken: json['pushToken'] as String?,
      );
}
