import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:threeminthinking/features/vocabulary/data/datasources/make_vocabulary_supabase_data_source.dart';
import 'package:threeminthinking/features/vocabulary/domain/repositories/make_vocabulary_repository.dart';

part 'make_vocabulary_repository_impl.g.dart';

class MakeVocabularyRepositoryImpl implements MakeVocabularyRepository {
  final MakeVocabularySupabaseDataSource _dataSource;

  MakeVocabularyRepositoryImpl(
    this._dataSource,
  );
}

@riverpod
MakeVocabularyRepositoryImpl makeVocabularyRepository(MakeVocabularyRepositoryRef ref) {
  return MakeVocabularyRepositoryImpl(
    ref.watch(makeVocabularySupabaseDataSourceProvider),
  );
}
