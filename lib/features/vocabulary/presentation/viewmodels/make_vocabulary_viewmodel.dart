import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:threeminthinking/features/vocabulary/data/repositories/make_vocabulary_repository_impl.dart';
import 'package:threeminthinking/features/vocabulary/domain/repositories/make_vocabulary_repository.dart';
import 'package:threeminthinking/features/vocabulary/presentation/viewmodels/make_vocabulary_state.dart';

part 'make_vocabulary_viewmodel.g.dart';

@riverpod
class MakeVocabularyViewModel extends _$MakeVocabularyViewModel {
  late final MakeVocabularyRepository _repository;

  @override
  Future<MakeVocabularyState> build() async {
    _repository = ref.watch(makeVocabularyRepositoryProvider);

    return const MakeVocabularyState();
  }
}
