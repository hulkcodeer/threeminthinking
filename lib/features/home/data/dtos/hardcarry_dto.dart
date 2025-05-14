import 'package:freezed_annotation/freezed_annotation.dart';

part 'hardcarry_dto.freezed.dart';
part 'hardcarry_dto.g.dart';

@freezed
class HardCarryDto with _$HardCarryDto {
  const factory HardCarryDto({
    required int winCount,
    required int loseCount,
    required String winImageType,
    required String loseImageType,
    required String winNickname,
    required String loseNickname,
    required Map<String, dynamic> period,
  }) = _HardCarryDto;

  factory HardCarryDto.fromJson(Map<String, dynamic> json) => _$HardCarryDtoFromJson(json);
}
