// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserInfoEntityImpl _$$UserInfoEntityImplFromJson(Map<String, dynamic> json) =>
    _$UserInfoEntityImpl(
      id: json['id'] as String,
      deviceId: json['deviceId'] as String,
      nickname: json['nickname'] as String,
      avatarImageType: json['avatarImageType'] as String,
      inviteCode: json['inviteCode'] as String?,
      pushToken: json['pushToken'] as String?,
    );

Map<String, dynamic> _$$UserInfoEntityImplToJson(
        _$UserInfoEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deviceId': instance.deviceId,
      'nickname': instance.nickname,
      'avatarImageType': instance.avatarImageType,
      'inviteCode': instance.inviteCode,
      'pushToken': instance.pushToken,
    };
