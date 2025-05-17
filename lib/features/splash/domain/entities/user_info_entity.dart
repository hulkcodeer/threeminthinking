import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info_entity.freezed.dart';
part 'user_info_entity.g.dart';

@freezed
class UserInfoEntity with _$UserInfoEntity {
  const factory UserInfoEntity({
    required String id,
    required String deviceId,
  }) = _UserInfoEntity;

  factory UserInfoEntity.empty() => const UserInfoEntity(
        id: '',
        deviceId: '',
      );

  factory UserInfoEntity.fromJson(Map<String, dynamic> json) => UserInfoEntity(
        id: json['id'] as String,
        deviceId: json['deviceId'] as String,
      );
}
