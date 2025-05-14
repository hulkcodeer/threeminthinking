// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_info_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserInfoDto _$UserInfoDtoFromJson(Map<String, dynamic> json) {
  return _UserInfoDto.fromJson(json);
}

/// @nodoc
mixin _$UserInfoDto {
  String get id => throw _privateConstructorUsedError;
  String get deviceId => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;
  String get avatarImageType => throw _privateConstructorUsedError;
  String? get inviteCode => throw _privateConstructorUsedError;
  String? get pushToken => throw _privateConstructorUsedError;
  String? get coupleId => throw _privateConstructorUsedError;

  /// Serializes this UserInfoDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserInfoDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserInfoDtoCopyWith<UserInfoDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserInfoDtoCopyWith<$Res> {
  factory $UserInfoDtoCopyWith(
          UserInfoDto value, $Res Function(UserInfoDto) then) =
      _$UserInfoDtoCopyWithImpl<$Res, UserInfoDto>;
  @useResult
  $Res call(
      {String id,
      String deviceId,
      String nickname,
      String avatarImageType,
      String? inviteCode,
      String? pushToken,
      String? coupleId});
}

/// @nodoc
class _$UserInfoDtoCopyWithImpl<$Res, $Val extends UserInfoDto>
    implements $UserInfoDtoCopyWith<$Res> {
  _$UserInfoDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserInfoDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? deviceId = null,
    Object? nickname = null,
    Object? avatarImageType = null,
    Object? inviteCode = freezed,
    Object? pushToken = freezed,
    Object? coupleId = freezed,
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
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      avatarImageType: null == avatarImageType
          ? _value.avatarImageType
          : avatarImageType // ignore: cast_nullable_to_non_nullable
              as String,
      inviteCode: freezed == inviteCode
          ? _value.inviteCode
          : inviteCode // ignore: cast_nullable_to_non_nullable
              as String?,
      pushToken: freezed == pushToken
          ? _value.pushToken
          : pushToken // ignore: cast_nullable_to_non_nullable
              as String?,
      coupleId: freezed == coupleId
          ? _value.coupleId
          : coupleId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserInfoDtoImplCopyWith<$Res>
    implements $UserInfoDtoCopyWith<$Res> {
  factory _$$UserInfoDtoImplCopyWith(
          _$UserInfoDtoImpl value, $Res Function(_$UserInfoDtoImpl) then) =
      __$$UserInfoDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String deviceId,
      String nickname,
      String avatarImageType,
      String? inviteCode,
      String? pushToken,
      String? coupleId});
}

/// @nodoc
class __$$UserInfoDtoImplCopyWithImpl<$Res>
    extends _$UserInfoDtoCopyWithImpl<$Res, _$UserInfoDtoImpl>
    implements _$$UserInfoDtoImplCopyWith<$Res> {
  __$$UserInfoDtoImplCopyWithImpl(
      _$UserInfoDtoImpl _value, $Res Function(_$UserInfoDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserInfoDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? deviceId = null,
    Object? nickname = null,
    Object? avatarImageType = null,
    Object? inviteCode = freezed,
    Object? pushToken = freezed,
    Object? coupleId = freezed,
  }) {
    return _then(_$UserInfoDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      avatarImageType: null == avatarImageType
          ? _value.avatarImageType
          : avatarImageType // ignore: cast_nullable_to_non_nullable
              as String,
      inviteCode: freezed == inviteCode
          ? _value.inviteCode
          : inviteCode // ignore: cast_nullable_to_non_nullable
              as String?,
      pushToken: freezed == pushToken
          ? _value.pushToken
          : pushToken // ignore: cast_nullable_to_non_nullable
              as String?,
      coupleId: freezed == coupleId
          ? _value.coupleId
          : coupleId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserInfoDtoImpl implements _UserInfoDto {
  const _$UserInfoDtoImpl(
      {required this.id,
      required this.deviceId,
      required this.nickname,
      required this.avatarImageType,
      this.inviteCode,
      this.pushToken,
      this.coupleId});

  factory _$UserInfoDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserInfoDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String deviceId;
  @override
  final String nickname;
  @override
  final String avatarImageType;
  @override
  final String? inviteCode;
  @override
  final String? pushToken;
  @override
  final String? coupleId;

  @override
  String toString() {
    return 'UserInfoDto(id: $id, deviceId: $deviceId, nickname: $nickname, avatarImageType: $avatarImageType, inviteCode: $inviteCode, pushToken: $pushToken, coupleId: $coupleId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserInfoDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.avatarImageType, avatarImageType) ||
                other.avatarImageType == avatarImageType) &&
            (identical(other.inviteCode, inviteCode) ||
                other.inviteCode == inviteCode) &&
            (identical(other.pushToken, pushToken) ||
                other.pushToken == pushToken) &&
            (identical(other.coupleId, coupleId) ||
                other.coupleId == coupleId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, deviceId, nickname,
      avatarImageType, inviteCode, pushToken, coupleId);

  /// Create a copy of UserInfoDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserInfoDtoImplCopyWith<_$UserInfoDtoImpl> get copyWith =>
      __$$UserInfoDtoImplCopyWithImpl<_$UserInfoDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserInfoDtoImplToJson(
      this,
    );
  }
}

abstract class _UserInfoDto implements UserInfoDto {
  const factory _UserInfoDto(
      {required final String id,
      required final String deviceId,
      required final String nickname,
      required final String avatarImageType,
      final String? inviteCode,
      final String? pushToken,
      final String? coupleId}) = _$UserInfoDtoImpl;

  factory _UserInfoDto.fromJson(Map<String, dynamic> json) =
      _$UserInfoDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get deviceId;
  @override
  String get nickname;
  @override
  String get avatarImageType;
  @override
  String? get inviteCode;
  @override
  String? get pushToken;
  @override
  String? get coupleId;

  /// Create a copy of UserInfoDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserInfoDtoImplCopyWith<_$UserInfoDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
