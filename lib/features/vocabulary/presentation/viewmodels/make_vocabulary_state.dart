import 'package:freezed_annotation/freezed_annotation.dart';

part 'make_vocabulary_state.freezed.dart';

@freezed
class MakeVocabularyState with _$MakeVocabularyState {
  const factory MakeVocabularyState({
    String? error,
  }) = _MakeVocabularyState;
}
