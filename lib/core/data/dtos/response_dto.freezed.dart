// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ResponseDto<T> _$ResponseDtoFromJson<T>(
    Map<String, dynamic> json, T Function(Object?) fromJsonT) {
  return _ResponseDto<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$ResponseDto<T> {
  bool get success => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  T? get data => throw _privateConstructorUsedError;

  /// Serializes this ResponseDto to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;

  /// Create a copy of ResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ResponseDtoCopyWith<T, ResponseDto<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResponseDtoCopyWith<T, $Res> {
  factory $ResponseDtoCopyWith(
          ResponseDto<T> value, $Res Function(ResponseDto<T>) then) =
      _$ResponseDtoCopyWithImpl<T, $Res, ResponseDto<T>>;
  @useResult
  $Res call({bool success, String? message, T? data});
}

/// @nodoc
class _$ResponseDtoCopyWithImpl<T, $Res, $Val extends ResponseDto<T>>
    implements $ResponseDtoCopyWith<T, $Res> {
  _$ResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResponseDtoImplCopyWith<T, $Res>
    implements $ResponseDtoCopyWith<T, $Res> {
  factory _$$ResponseDtoImplCopyWith(_$ResponseDtoImpl<T> value,
          $Res Function(_$ResponseDtoImpl<T>) then) =
      __$$ResponseDtoImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({bool success, String? message, T? data});
}

/// @nodoc
class __$$ResponseDtoImplCopyWithImpl<T, $Res>
    extends _$ResponseDtoCopyWithImpl<T, $Res, _$ResponseDtoImpl<T>>
    implements _$$ResponseDtoImplCopyWith<T, $Res> {
  __$$ResponseDtoImplCopyWithImpl(
      _$ResponseDtoImpl<T> _value, $Res Function(_$ResponseDtoImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of ResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$ResponseDtoImpl<T>(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T?,
    ));
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$ResponseDtoImpl<T> implements _ResponseDto<T> {
  const _$ResponseDtoImpl({required this.success, this.message, this.data});

  factory _$ResponseDtoImpl.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$$ResponseDtoImplFromJson(json, fromJsonT);

  @override
  final bool success;
  @override
  final String? message;
  @override
  final T? data;

  @override
  String toString() {
    return 'ResponseDto<$T>(success: $success, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResponseDtoImpl<T> &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, success, message, const DeepCollectionEquality().hash(data));

  /// Create a copy of ResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResponseDtoImplCopyWith<T, _$ResponseDtoImpl<T>> get copyWith =>
      __$$ResponseDtoImplCopyWithImpl<T, _$ResponseDtoImpl<T>>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$ResponseDtoImplToJson<T>(this, toJsonT);
  }
}

abstract class _ResponseDto<T> implements ResponseDto<T> {
  const factory _ResponseDto(
      {required final bool success,
      final String? message,
      final T? data}) = _$ResponseDtoImpl<T>;

  factory _ResponseDto.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =
      _$ResponseDtoImpl<T>.fromJson;

  @override
  bool get success;
  @override
  String? get message;
  @override
  T? get data;

  /// Create a copy of ResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResponseDtoImplCopyWith<T, _$ResponseDtoImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
