import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/material.dart';
import 'package:threeminthinking/features/vocabulary/data/repositories/make_vocabulary_repository_impl.dart';
import 'package:threeminthinking/features/vocabulary/domain/repositories/make_vocabulary_repository.dart';
import 'package:threeminthinking/features/vocabulary/presentation/viewmodels/make_vocabulary_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'make_vocabulary_viewmodel.g.dart';

@riverpod
class MakeVocabularyViewModel extends _$MakeVocabularyViewModel {
  late final MakeVocabularyRepository _repository;

  @override
  Future<MakeVocabularyState> build() async {
    _repository = ref.watch(makeVocabularyRepositoryProvider);
    return const MakeVocabularyState();
  }

  // 사전 API를 호출하여 단어 검색
  Future<void> searchWord(String word) async {
    state = AsyncValue.loading();

    try {
      final result = await _repository.searchWord(word);
      print(result);

      state = AsyncData(state.value!.copyWith(
        searchResult: result,
        isSearching: false,
      ));
    } catch (e) {
      state = AsyncData(state.value!.copyWith(
        errorMessage: '오류가 발생했습니다: $e',
        isSearching: false,
      ));
    }
  }

  // 단어장 생성 함수
  Future<bool> createWordbook(
      String name, String description, String color, String languageFrom, String languageTo) async {
    state = AsyncValue.loading();

    try {
      // Supabase에 책장이 없으면 기본 책장 생성
      final hasBookshelf = await _repository.hasDefaultBookshelf();
      if (!hasBookshelf) {
        await _repository.createDefaultBookshelf();
      }

      // 단어장 생성
      final result = await _repository.createWordbook(name, description, color, languageFrom, languageTo);

      if (result) {
        state = AsyncData(state.value!.copyWith(
          isCreated: true,
          errorMessage: null,
        ));
        return true;
      } else {
        state = AsyncData(state.value!.copyWith(
          errorMessage: '단어장 생성에 실패했습니다',
        ));
        return false;
      }
    } catch (e) {
      state = AsyncData(state.value!.copyWith(
        errorMessage: '오류가 발생했습니다: $e',
      ));
      return false;
    }
  }
}
