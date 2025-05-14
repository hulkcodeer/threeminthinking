import 'package:freezed_annotation/freezed_annotation.dart';

part 'hard_carry_entity.freezed.dart';

@freezed
class HardCarryEntity with _$HardCarryEntity {
  const factory HardCarryEntity({
    required int winCount,
    required int loseCount,
    required String winImageType,
    required String loseImageType,
    required String winNickname,
    required String loseNickname,
    required Map<String, dynamic> period,
  }) = _HardCarryEntity;
}
