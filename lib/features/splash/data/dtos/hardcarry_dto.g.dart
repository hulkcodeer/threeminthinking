// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hardcarry_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HardCarryDtoImpl _$$HardCarryDtoImplFromJson(Map<String, dynamic> json) =>
    _$HardCarryDtoImpl(
      winCount: (json['winCount'] as num).toInt(),
      loseCount: (json['loseCount'] as num).toInt(),
      winImageType: json['winImageType'] as String,
      loseImageType: json['loseImageType'] as String,
      winNickname: json['winNickname'] as String,
      loseNickname: json['loseNickname'] as String,
      period: json['period'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$HardCarryDtoImplToJson(_$HardCarryDtoImpl instance) =>
    <String, dynamic>{
      'winCount': instance.winCount,
      'loseCount': instance.loseCount,
      'winImageType': instance.winImageType,
      'loseImageType': instance.loseImageType,
      'winNickname': instance.winNickname,
      'loseNickname': instance.loseNickname,
      'period': instance.period,
    };
