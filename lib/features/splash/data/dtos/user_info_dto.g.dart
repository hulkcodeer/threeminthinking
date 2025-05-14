// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserInfoDtoImpl _$$UserInfoDtoImplFromJson(Map<String, dynamic> json) =>
    _$UserInfoDtoImpl(
      id: json['id'] as String,
      deviceId: json['deviceId'] as String,
      nickname: json['nickname'] as String,
      avatarImageType: json['avatarImageType'] as String,
      inviteCode: json['inviteCode'] as String?,
      pushToken: json['pushToken'] as String?,
      coupleId: json['coupleId'] as String?,
    );

Map<String, dynamic> _$$UserInfoDtoImplToJson(_$UserInfoDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deviceId': instance.deviceId,
      'nickname': instance.nickname,
      'avatarImageType': instance.avatarImageType,
      'inviteCode': instance.inviteCode,
      'pushToken': instance.pushToken,
      'coupleId': instance.coupleId,
    };
