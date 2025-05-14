import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:threeminthinking/core/providers/supabase_provider.dart';

part 'make_vocabulary_supabase_data_source.g.dart';

class MakeVocabularySupabaseDataSource {
  final SupabaseClient _client;

  MakeVocabularySupabaseDataSource(this._client);

  Future<bool> hasDefaultBookshelf() async {
    try {
      final userId = _client.auth.currentUser?.id;
      if (userId == null) return false;

      final response = await _client.from('bookshelves').select('id').eq('user_id', userId).limit(1).maybeSingle();

      return response != null;
    } catch (e) {
      print('MakeVocabularyRepositoryImpl hasDefaultBookshelf error: $e');
      return false;
    }
  }

  Future<bool> createDefaultBookshelf() async {
    try {
      final userId = _client.auth.currentUser?.id;
      if (userId == null) return false;

      await _client.from('bookshelves').insert({
        'user_id': userId,
        'name': '내 책장',
        'description': '기본 책장',
        'icon': 'bookshelf',
        'color': 'blue',
      });

      return true;
    } catch (e) {
      print('MakeVocabularyRepositoryImpl createDefaultBookshelf error: $e');
      return false;
    }
  }

  Future<bool> createWordbook(
      String name, String description, String color, String languageFrom, String languageTo) async {
    try {
      final userId = _client.auth.currentUser?.id;
      if (userId == null) return false;

      // 사용자의 첫 번째 책장 ID 가져오기
      final bookshelf = await _client.from('bookshelves').select('id').eq('user_id', userId).limit(1).single();

      final bookshelfId = bookshelf['id'];

      // 단어장 생성
      await _client.from('wordbooks').insert({
        'user_id': userId,
        'bookshelf_id': bookshelfId,
        'name': name,
        'description': description,
        'color': color,
        'language_from': languageFrom,
        'language_to': languageTo,
      });

      return true;
    } catch (e) {
      print('MakeVocabularyRepositoryImpl createWordbook error: $e');
      return false;
    }
  }
}

@riverpod
MakeVocabularySupabaseDataSource makeVocabularySupabaseDataSource(MakeVocabularySupabaseDataSourceRef ref) {
  return MakeVocabularySupabaseDataSource(ref.watch(supabaseProvider));
}
