// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thinking_state_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ThinkingStateImpl _$$ThinkingStateImplFromJson(Map<String, dynamic> json) =>
    _$ThinkingStateImpl(
      timeLeft: (json['timeLeft'] as num?)?.toInt() ?? 180,
      showStartModal: json['showStartModal'] as bool? ?? false,
      showEndModal: json['showEndModal'] as bool? ?? false,
      thinkingDesc: json['thinkingDesc'] as String? ?? "",
      isTimerRunning: json['isTimerRunning'] as bool? ?? false,
      showHint: json['showHint'] as bool? ?? false,
      currentHint: json['currentHint'] as String? ?? "",
      isEditable: json['isEditable'] as bool? ?? false,
    );

Map<String, dynamic> _$$ThinkingStateImplToJson(_$ThinkingStateImpl instance) =>
    <String, dynamic>{
      'timeLeft': instance.timeLeft,
      'showStartModal': instance.showStartModal,
      'showEndModal': instance.showEndModal,
      'thinkingDesc': instance.thinkingDesc,
      'isTimerRunning': instance.isTimerRunning,
      'showHint': instance.showHint,
      'currentHint': instance.currentHint,
      'isEditable': instance.isEditable,
    };
