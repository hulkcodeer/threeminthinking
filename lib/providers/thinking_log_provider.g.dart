// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thinking_log_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ThinkingLogImpl _$$ThinkingLogImplFromJson(Map<String, dynamic> json) =>
    _$ThinkingLogImpl(
      id: (json['id'] as num).toInt(),
      deviceId: json['deviceId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      thinkingDesc: json['thinkingDesc'] as String,
      dateDesc: json['dateDesc'] as String,
    );

Map<String, dynamic> _$$ThinkingLogImplToJson(_$ThinkingLogImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deviceId': instance.deviceId,
      'createdAt': instance.createdAt.toIso8601String(),
      'thinkingDesc': instance.thinkingDesc,
      'dateDesc': instance.dateDesc,
    };
