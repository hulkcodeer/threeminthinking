// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'thinking_log_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ThinkingLog _$ThinkingLogFromJson(Map<String, dynamic> json) {
  return _ThinkingLog.fromJson(json);
}

/// @nodoc
mixin _$ThinkingLog {
  int get id => throw _privateConstructorUsedError;
  String get deviceId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get thinkingDesc => throw _privateConstructorUsedError;
  String get dateDesc => throw _privateConstructorUsedError;

  /// Serializes this ThinkingLog to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ThinkingLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ThinkingLogCopyWith<ThinkingLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThinkingLogCopyWith<$Res> {
  factory $ThinkingLogCopyWith(
          ThinkingLog value, $Res Function(ThinkingLog) then) =
      _$ThinkingLogCopyWithImpl<$Res, ThinkingLog>;
  @useResult
  $Res call(
      {int id,
      String deviceId,
      DateTime createdAt,
      String thinkingDesc,
      String dateDesc});
}

/// @nodoc
class _$ThinkingLogCopyWithImpl<$Res, $Val extends ThinkingLog>
    implements $ThinkingLogCopyWith<$Res> {
  _$ThinkingLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ThinkingLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? deviceId = null,
    Object? createdAt = null,
    Object? thinkingDesc = null,
    Object? dateDesc = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      thinkingDesc: null == thinkingDesc
          ? _value.thinkingDesc
          : thinkingDesc // ignore: cast_nullable_to_non_nullable
              as String,
      dateDesc: null == dateDesc
          ? _value.dateDesc
          : dateDesc // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ThinkingLogImplCopyWith<$Res>
    implements $ThinkingLogCopyWith<$Res> {
  factory _$$ThinkingLogImplCopyWith(
          _$ThinkingLogImpl value, $Res Function(_$ThinkingLogImpl) then) =
      __$$ThinkingLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String deviceId,
      DateTime createdAt,
      String thinkingDesc,
      String dateDesc});
}

/// @nodoc
class __$$ThinkingLogImplCopyWithImpl<$Res>
    extends _$ThinkingLogCopyWithImpl<$Res, _$ThinkingLogImpl>
    implements _$$ThinkingLogImplCopyWith<$Res> {
  __$$ThinkingLogImplCopyWithImpl(
      _$ThinkingLogImpl _value, $Res Function(_$ThinkingLogImpl) _then)
      : super(_value, _then);

  /// Create a copy of ThinkingLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? deviceId = null,
    Object? createdAt = null,
    Object? thinkingDesc = null,
    Object? dateDesc = null,
  }) {
    return _then(_$ThinkingLogImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      thinkingDesc: null == thinkingDesc
          ? _value.thinkingDesc
          : thinkingDesc // ignore: cast_nullable_to_non_nullable
              as String,
      dateDesc: null == dateDesc
          ? _value.dateDesc
          : dateDesc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ThinkingLogImpl with DiagnosticableTreeMixin implements _ThinkingLog {
  const _$ThinkingLogImpl(
      {required this.id,
      required this.deviceId,
      required this.createdAt,
      required this.thinkingDesc,
      required this.dateDesc});

  factory _$ThinkingLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$ThinkingLogImplFromJson(json);

  @override
  final int id;
  @override
  final String deviceId;
  @override
  final DateTime createdAt;
  @override
  final String thinkingDesc;
  @override
  final String dateDesc;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ThinkingLog(id: $id, deviceId: $deviceId, createdAt: $createdAt, thinkingDesc: $thinkingDesc, dateDesc: $dateDesc)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ThinkingLog'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('deviceId', deviceId))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('thinkingDesc', thinkingDesc))
      ..add(DiagnosticsProperty('dateDesc', dateDesc));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThinkingLogImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.thinkingDesc, thinkingDesc) ||
                other.thinkingDesc == thinkingDesc) &&
            (identical(other.dateDesc, dateDesc) ||
                other.dateDesc == dateDesc));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, deviceId, createdAt, thinkingDesc, dateDesc);

  /// Create a copy of ThinkingLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ThinkingLogImplCopyWith<_$ThinkingLogImpl> get copyWith =>
      __$$ThinkingLogImplCopyWithImpl<_$ThinkingLogImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ThinkingLogImplToJson(
      this,
    );
  }
}

abstract class _ThinkingLog implements ThinkingLog {
  const factory _ThinkingLog(
      {required final int id,
      required final String deviceId,
      required final DateTime createdAt,
      required final String thinkingDesc,
      required final String dateDesc}) = _$ThinkingLogImpl;

  factory _ThinkingLog.fromJson(Map<String, dynamic> json) =
      _$ThinkingLogImpl.fromJson;

  @override
  int get id;
  @override
  String get deviceId;
  @override
  DateTime get createdAt;
  @override
  String get thinkingDesc;
  @override
  String get dateDesc;

  /// Create a copy of ThinkingLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ThinkingLogImplCopyWith<_$ThinkingLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
