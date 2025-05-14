import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:threeminthinking/core/uitils/app_color.dart';
import 'package:threeminthinking/core/uitils/fonts.dart';
import 'package:threeminthinking/features/vocabulary/presentation/viewmodels/make_vocabulary_viewmodel.dart';
import 'package:threeminthinking/features/vocabulary/presentation/viewmodels/make_vocabulary_state.dart';

class MakeVocabularyPage extends ConsumerStatefulWidget {
  const MakeVocabularyPage({super.key});

  @override
  ConsumerState<MakeVocabularyPage> createState() => _MakeVocabularyPageState();
}

class _MakeVocabularyPageState extends ConsumerState<MakeVocabularyPage> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _wordbookNameController = TextEditingController();
  final TextEditingController _wordbookDescriptionController = TextEditingController();

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _canPlay = true;

  String _selectedColor = "blue";
  String _languageFrom = "en";
  String _languageTo = "ko";

  // 단어장 생성 UI 표시 여부
  bool _showCreateForm = false;
  Map<String, dynamic>? _wordData;

  final List<Map<String, dynamic>> _colorOptions = [
    {"name": "blue", "color": Colors.blue},
    {"name": "red", "color": Colors.red},
    {"name": "green", "color": Colors.green},
    {"name": "purple", "color": Colors.purple},
    {"name": "orange", "color": Colors.orange},
  ];

  final List<Map<String, String>> _languageOptions = [
    {"code": "en", "name": "영어"},
    {"code": "ko", "name": "한국어"},
    {"code": "ja", "name": "일본어"},
    {"code": "zh", "name": "중국어"},
    {"code": "fr", "name": "프랑스어"},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    _wordbookNameController.dispose();
    _wordbookDescriptionController.dispose();

    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _searchWord(String word) async {
    if (word.isEmpty) return;

    setState(() {
      _wordData = null;
    });

    final result = await ref.read(makeVocabularyViewModelProvider.notifier).searchWord(word);
    if (result != null) {
      setState(() {
        _wordData = result;
      });
    }
  }

  Future<void> _createWordbook() async {
    if (_wordbookNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('단어장 이름을 입력해주세요')),
      );
      return;
    }

    final result = await ref.read(makeVocabularyViewModelProvider.notifier).createWordbook(
          _wordbookNameController.text,
          _wordbookDescriptionController.text,
          _selectedColor,
          _languageFrom,
          _languageTo,
        );

    if (result) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('단어장이 생성되었습니다')),
      );
      setState(() {
        _showCreateForm = false;
        _wordbookNameController.clear();
        _wordbookDescriptionController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final vocabularyState = ref.watch(makeVocabularyViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('베어보카'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                _showCreateForm = !_showCreateForm;
              });
            },
          ),
        ],
      ),
      body: vocabularyState.when(
        data: (state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: _showCreateForm ? _buildCreateWordbookForm() : _buildSearchWordForm(state),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('오류가 발생했습니다: $error')),
      ),
    );
  }

  Widget _buildCreateWordbookForm() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('새 단어장 만들기', style: AppFonts.bold15.copyWith(color: AppColors.black)),
          const SizedBox(height: 16),

          // 단어장 이름
          TextField(
            controller: _wordbookNameController,
            decoration: InputDecoration(
              labelText: '단어장 이름',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // 단어장 설명
          TextField(
            controller: _wordbookDescriptionController,
            decoration: InputDecoration(
              labelText: '설명 (선택사항)',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            maxLines: 3,
          ),

          const SizedBox(height: 16),

          // 색상 선택
          Text('색상', style: AppFonts.medium14),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: _colorOptions.map((option) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedColor = option['name'];
                  });
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: option['color'],
                    shape: BoxShape.circle,
                    border: _selectedColor == option['name'] ? Border.all(color: Colors.black, width: 2) : null,
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 24),

          // 언어 설정
          Text('언어 설정', style: AppFonts.medium14),
          const SizedBox(height: 8),

          // From 언어
          DropdownButtonFormField<String>(
            value: _languageFrom,
            decoration: InputDecoration(
              labelText: '원본 언어',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            items: _languageOptions.map((option) {
              return DropdownMenuItem(
                value: option['code'],
                child: Text(option['name']!),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _languageFrom = value!;
              });
            },
          ),

          const SizedBox(height: 16),

          // To 언어
          DropdownButtonFormField<String>(
            value: _languageTo,
            decoration: InputDecoration(
              labelText: '번역 언어',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            items: _languageOptions.map((option) {
              return DropdownMenuItem(
                value: option['code'],
                child: Text(option['name']!),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _languageTo = value!;
              });
            },
          ),

          const SizedBox(height: 24),

          // 생성 버튼
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: _createWordbook,
              child: const Text('단어장 만들기'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchWordForm(MakeVocabularyState state) {
    return Column(
      children: [
        // 검색창
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: '영어 단어 입력',
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => _searchWord(_searchController.text.trim()),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onSubmitted: (value) => _searchWord(value.trim()),
        ),

        const SizedBox(height: 16),

        // 오류 메시지 표시
        if (state.errorMessage != null) Text(state.errorMessage!, style: AppFonts.medium14.copyWith(color: Colors.red)),

        // 결과 표시
        if (_wordData != null)
          Expanded(
            child: _buildWordDetailView(),
          ),
      ],
    );
  }

  Future<void> _playPronunciation(String audioUrl) async {
    if (!_canPlay) return;

    try {
      _canPlay = false; // 재생 중 중복 클릭 방지

      // 이미 로드된 상태라면 먼저 중지하고 자원 해제
      await _audioPlayer.stop();

      // 새 오디오 URL 설정
      await _audioPlayer.setUrl(audioUrl);

      // 재생 완료 이벤트 리스너
      _audioPlayer.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          _canPlay = true; // 재생 완료 시 플래그 복원
        }
      });

      // 재생
      await _audioPlayer.play();
    } catch (e) {
      print('오디오 재생 오류: $e');
      _canPlay = true; // 오류 발생 시에도 플래그 복원
    }
  }

  Widget _buildWordDetailView() {
    return SingleChildScrollView(
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
                      final audioUrl = _wordData?['phonetics']?[0]?['audio'];
                      if (audioUrl != null && audioUrl.isNotEmpty) {
                        _playPronunciation(audioUrl);
                      }
                    },
                  ),
              ],
            ),

          const SizedBox(height: 20),

          // 의미 목록
          if (_wordData!['meanings'] != null) ..._buildMeanings(_wordData!['meanings']),

          const SizedBox(height: 16),

          // 단어장에 추가 버튼
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              // 단어 저장 기능 구현 필요
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('먼저 단어장을 생성해주세요 (+ 버튼)')),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('단어장에 추가'),
          ),
        ],
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
