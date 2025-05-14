import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:threeminthinking/features/vocabulary/data/datasources/make_vocabulary_supabase_data_source.dart';
import 'package:threeminthinking/features/vocabulary/domain/repositories/make_vocabulary_repository.dart';

part 'make_vocabulary_repository_impl.g.dart';

class MakeVocabularyRepositoryImpl implements MakeVocabularyRepository {
  final MakeVocabularySupabaseDataSource _dataSource;

  MakeVocabularyRepositoryImpl(
    this._dataSource,
  );

  @override
  Future<bool> hasDefaultBookshelf() async {
    return _dataSource.hasDefaultBookshelf();
  }

  @override
  Future<bool> createDefaultBookshelf() async {
    return _dataSource.createDefaultBookshelf();
  }

  @override
  Future<bool> createWordbook(
      String name, String description, String color, String languageFrom, String languageTo) async {
    return _dataSource.createWordbook(name, description, color, languageFrom, languageTo);
  }
}

@riverpod
MakeVocabularyRepositoryImpl makeVocabularyRepository(MakeVocabularyRepositoryRef ref) {
  return MakeVocabularyRepositoryImpl(
    ref.watch(makeVocabularySupabaseDataSourceProvider),
  );
}
