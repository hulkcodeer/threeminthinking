// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'make_vocabulary_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MakeVocabularyState {
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of MakeVocabularyState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MakeVocabularyStateCopyWith<MakeVocabularyState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MakeVocabularyStateCopyWith<$Res> {
  factory $MakeVocabularyStateCopyWith(
          MakeVocabularyState value, $Res Function(MakeVocabularyState) then) =
      _$MakeVocabularyStateCopyWithImpl<$Res, MakeVocabularyState>;
  @useResult
  $Res call({String? error});
}

/// @nodoc
class _$MakeVocabularyStateCopyWithImpl<$Res, $Val extends MakeVocabularyState>
    implements $MakeVocabularyStateCopyWith<$Res> {
  _$MakeVocabularyStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MakeVocabularyState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MakeVocabularyStateImplCopyWith<$Res>
    implements $MakeVocabularyStateCopyWith<$Res> {
  factory _$$MakeVocabularyStateImplCopyWith(_$MakeVocabularyStateImpl value,
          $Res Function(_$MakeVocabularyStateImpl) then) =
      __$$MakeVocabularyStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? error});
}

/// @nodoc
class __$$MakeVocabularyStateImplCopyWithImpl<$Res>
    extends _$MakeVocabularyStateCopyWithImpl<$Res, _$MakeVocabularyStateImpl>
    implements _$$MakeVocabularyStateImplCopyWith<$Res> {
  __$$MakeVocabularyStateImplCopyWithImpl(_$MakeVocabularyStateImpl _value,
      $Res Function(_$MakeVocabularyStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of MakeVocabularyState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_$MakeVocabularyStateImpl(
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$MakeVocabularyStateImpl implements _MakeVocabularyState {
  const _$MakeVocabularyStateImpl({this.error});

  @override
  final String? error;

  @override
  String toString() {
    return 'MakeVocabularyState(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MakeVocabularyStateImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of MakeVocabularyState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MakeVocabularyStateImplCopyWith<_$MakeVocabularyStateImpl> get copyWith =>
      __$$MakeVocabularyStateImplCopyWithImpl<_$MakeVocabularyStateImpl>(
          this, _$identity);
}

abstract class _MakeVocabularyState implements MakeVocabularyState {
  const factory _MakeVocabularyState({final String? error}) =
      _$MakeVocabularyStateImpl;

  @override
  String? get error;

  /// Create a copy of MakeVocabularyState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MakeVocabularyStateImplCopyWith<_$MakeVocabularyStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
