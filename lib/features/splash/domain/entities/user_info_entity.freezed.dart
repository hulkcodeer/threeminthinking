// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_info_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserInfoEntity _$UserInfoEntityFromJson(Map<String, dynamic> json) {
  return _UserInfoEntity.fromJson(json);
}

/// @nodoc
mixin _$UserInfoEntity {
  String get id => throw _privateConstructorUsedError;
  String get deviceId => throw _privateConstructorUsedError;

  /// Serializes this UserInfoEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserInfoEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserInfoEntityCopyWith<UserInfoEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserInfoEntityCopyWith<$Res> {
  factory $UserInfoEntityCopyWith(
          UserInfoEntity value, $Res Function(UserInfoEntity) then) =
      _$UserInfoEntityCopyWithImpl<$Res, UserInfoEntity>;
  @useResult
  $Res call({String id, String deviceId});
}

/// @nodoc
class _$UserInfoEntityCopyWithImpl<$Res, $Val extends UserInfoEntity>
    implements $UserInfoEntityCopyWith<$Res> {
  _$UserInfoEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserInfoEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? deviceId = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserInfoEntityImplCopyWith<$Res>
    implements $UserInfoEntityCopyWith<$Res> {
  factory _$$UserInfoEntityImplCopyWith(_$UserInfoEntityImpl value,
          $Res Function(_$UserInfoEntityImpl) then) =
      __$$UserInfoEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String deviceId});
}

/// @nodoc
class __$$UserInfoEntityImplCopyWithImpl<$Res>
    extends _$UserInfoEntityCopyWithImpl<$Res, _$UserInfoEntityImpl>
    implements _$$UserInfoEntityImplCopyWith<$Res> {
  __$$UserInfoEntityImplCopyWithImpl(
      _$UserInfoEntityImpl _value, $Res Function(_$UserInfoEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserInfoEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? deviceId = null,
  }) {
    return _then(_$UserInfoEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserInfoEntityImpl implements _UserInfoEntity {
  const _$UserInfoEntityImpl({required this.id, required this.deviceId});

  factory _$UserInfoEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserInfoEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String deviceId;

  @override
  String toString() {
    return 'UserInfoEntity(id: $id, deviceId: $deviceId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserInfoEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, deviceId);

  /// Create a copy of UserInfoEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserInfoEntityImplCopyWith<_$UserInfoEntityImpl> get copyWith =>
      __$$UserInfoEntityImplCopyWithImpl<_$UserInfoEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserInfoEntityImplToJson(
      this,
    );
  }
}

abstract class _UserInfoEntity implements UserInfoEntity {
  const factory _UserInfoEntity(
      {required final String id,
      required final String deviceId}) = _$UserInfoEntityImpl;

  factory _UserInfoEntity.fromJson(Map<String, dynamic> json) =
      _$UserInfoEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get deviceId;

  /// Create a copy of UserInfoEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserInfoEntityImplCopyWith<_$UserInfoEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
