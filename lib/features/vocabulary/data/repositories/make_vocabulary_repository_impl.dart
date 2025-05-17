import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:threeminthinking/core/di/api_providers.dart';
import 'package:threeminthinking/features/vocabulary/data/datasources/make_vocabulary_supabase_data_source.dart';
import 'package:threeminthinking/features/vocabulary/data/services/word_api_service.dart';
import 'package:threeminthinking/features/vocabulary/domain/repositories/make_vocabulary_repository.dart';

part 'make_vocabulary_repository_impl.g.dart';

class MakeVocabularyRepositoryImpl implements MakeVocabularyRepository {
  final MakeVocabularySupabaseDataSource _dataSource;
  final WordApiService _wordApiService;

  MakeVocabularyRepositoryImpl(
    this._dataSource,
    this._wordApiService,
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

  @override
  Future<Map<String, dynamic>> searchWord(String word) async {
    try {
      final response = await _wordApiService.searchWord({
        "model": "gpt-3.5-turbo",
        "messages": [
          {
            "role": "system",
            "content": """You are a helpful English-Korean dictionary assistant.
          Always respond in the following JSON format:
          {
            "word": "$word",
            "meanings": [
              {
                "partOfSpeech": "품사 (한글로 표시, 예: 명사, 동사, 형용사 등)",
                "definitions": [
                  {
                    "definition": "한국어 의미",
                    "example": "예문 (영어 원문)",
                    "exampleTranslation": "예문 번역 (한글)"
                  }
                ],
                "synonyms": ["동의어1", "동의어2"],
                "antonyms": ["반의어1", "반의어2"]
              }
            ]
          }
          Do not include any explanations or additional text, just the JSON."""
          },
          {"role": "user", "content": "$word 단어의 정보를 위 JSON 형식으로 제공해주세요."}
        ],
        "temperature": 0.3,
        "max_tokens": 500,
        "response_format": {"type": "json_object"}
      });

      final content = response['choices'][0]['message']['content'];
      return Map<String, dynamic>.from(jsonDecode(content));
    } catch (e) {
      throw Exception('단어 검색 실패: $e');
    }
  }
}

@riverpod
MakeVocabularyRepositoryImpl makeVocabularyRepository(MakeVocabularyRepositoryRef ref) {
  return MakeVocabularyRepositoryImpl(
    ref.watch(makeVocabularySupabaseDataSourceProvider),
    ref.watch(wordApiServiceProvider),
  );
}
