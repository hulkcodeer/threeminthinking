import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:threeminthinking/core/uitils/app_color.dart';
import 'package:threeminthinking/core/uitils/fonts.dart';

class MakeVocabularyPage extends StatefulWidget {
  const MakeVocabularyPage({super.key});

  @override
  State<MakeVocabularyPage> createState() => _MakeVocabularyPageState();
}

class _MakeVocabularyPageState extends State<MakeVocabularyPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  Map<String, dynamic>? _wordData;
  String? _errorMessage;

  Future<void> _searchWord(String word) async {
    if (word.isEmpty) return;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('단어장 만들기'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 검색창
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '영어 단어 입력',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => _searchWord(_searchController.text.trim()),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onSubmitted: (value) => _searchWord(value.trim()),
            ),

            const SizedBox(height: 16),

            // 로딩 상태 표시
            if (_isLoading) const CircularProgressIndicator(),

            // 오류 메시지 표시
            if (_errorMessage != null) Text(_errorMessage!, style: AppFonts.medium14.copyWith(color: Colors.red)),

            // 결과 표시
            if (_wordData != null)
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 단어와 발음
                      Text(
                        _wordData!['word'] ?? '',
                        style: AppFonts.regular12.copyWith(color: AppColors.black),
                      ),
                      if (_wordData!['phonetics'] != null && (_wordData!['phonetics'] as List).isNotEmpty)
                        Row(
                          children: [
                            Text(
                              (_wordData!['phonetics'][0]['text'] ?? ''),
                              style: AppFonts.medium14.copyWith(color: AppColors.gray),
                            ),
                            if ((_wordData!['phonetics'][0]['audio'] as String?)?.isNotEmpty ?? false)
                              IconButton(
                                icon: const Icon(Icons.volume_up),
                                onPressed: () {
                                  // 오디오 재생 로직 구현 필요
                                },
                              ),
                          ],
                        ),

                      const SizedBox(height: 20),

                      // 의미 목록
                      if (_wordData!['meanings'] != null) ..._buildMeanings(_wordData!['meanings']),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildMeanings(List meanings) {
    List<Widget> meaningWidgets = [];

    for (var meaning in meanings) {
      // 품사
      meaningWidgets.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.grayBg,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            meaning['partOfSpeech'] ?? '',
            style: AppFonts.medium14.copyWith(color: AppColors.black),
          ),
        ),
      );

      // 정의 목록
      if (meaning['definitions'] != null) {
        for (var i = 0; i < (meaning['definitions'] as List).length; i++) {
          var definition = meaning['definitions'][i];
          meaningWidgets.add(
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 정의
                  Text(
                    '${i + 1}. ${definition['definition'] ?? ''}',
                    style: AppFonts.regular12.copyWith(color: AppColors.black),
                  ),

                  // 예문
                  if (definition['example'] != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 16.0),
                      child: Text(
                        '"${definition['example']}"',
                        style: AppFonts.regular12.copyWith(color: AppColors.gray),
                      ),
                    ),

                  // 동의어
                  if (definition['synonyms'] != null && (definition['synonyms'] as List).isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 16.0),
                      child: Wrap(
                        spacing: 8,
                        children: [
                          Text('동의어:', style: AppFonts.bold12),
                          ...(definition['synonyms'] as List)
                              .take(5)
                              .map((synonym) => Text(synonym, style: AppFonts.regular12))
                              .toList(),
                        ],
                      ),
                    ),

                  // 반의어
                  if (definition['antonyms'] != null && (definition['antonyms'] as List).isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 16.0),
                      child: Wrap(
                        spacing: 8,
                        children: [
                          Text('반의어:', style: AppFonts.bold12),
                          ...(definition['antonyms'] as List)
                              .take(5)
                              .map((antonym) => Text(antonym, style: AppFonts.regular12))
                              .toList(),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );
        }
      }

      meaningWidgets.add(const Divider());
    }

    return meaningWidgets;
  }
}
