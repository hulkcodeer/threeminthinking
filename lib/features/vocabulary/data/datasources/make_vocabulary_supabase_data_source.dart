import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:threeminthinking/core/providers/supabase_provider.dart';

part 'make_vocabulary_supabase_data_source.g.dart';

class MakeVocabularySupabaseDataSource {
  final SupabaseClient _client;

  MakeVocabularySupabaseDataSource(this._client);

  // @override
  // Future<ResponseDto<HardCarryDto>> getHardCarryInfo(String userId) async {
  //   try {
  //     // 1. 사용자와 커플 정보 조회
  //     final userResponse = await _client
  //         .from('User')
  //         .select('*, couple:Couple(id, users:User(*))')
  //         .eq('deviceId', userId)
  //         .single();

  //     if (userResponse == null || userResponse['couple'] == null) {
  //       return ResponseDto(
  //         success: false,
  //         message: "User or couple not found",
  //       );
  //     }

  //     if (userResponse['isShowHardCarry'] == true) {
  //       return ResponseDto(success: true);
  //     }

  //     // 2. 지난 주의 시작과 끝 날짜 계산
  //     final today = DateTime.now();
  //     final lastMonday = today
  //         .subtract(
  //           Duration(days: today.weekday + 6),
  //         )
  //         .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0);

  //     final lastSunday = today
  //         .subtract(
  //           Duration(days: today.weekday),
  //         )
  //         .copyWith(hour: 23, minute: 59, second: 59, millisecond: 999);

  //     // 3. 완료된 태스크 조회
  //     final tasksResponse = await _client
  //         .from('Task')
  //         .select('*, assignee:User(*)')
  //         .eq('coupleId', userResponse['couple']['id'])
  //         .eq('isTogether', false)
  //         .eq('status', 'COMPLETED')
  //         .gte('createdAt', lastMonday.toIso8601String())
  //         .lte('createdAt', lastSunday.toIso8601String());

  //     // 4. 사용자별 완료 태스크 수 계산
  //     final completedTasksByUser = <String, int>{};
  //     for (final task in tasksResponse) {
  //       if (task['assigneeId'] != null) {
  //         completedTasksByUser[task['assigneeId']] =
  //             (completedTasksByUser[task['assigneeId']] ?? 0) + 1;
  //       }
  //     }

  //     return ResponseDto(
  //       success: true,
  //       data: HardCarryDto(
  //         winCount: completedTasksByUser.values.reduce((a, b) => a + b),
  //         loseCount: 0,
  //         winImageType: 'hardcarry',
  //         loseImageType: 'hardcarry',
  //         winNickname: userResponse['couple']['users'][0]['nickname'],
  //         loseNickname: userResponse['couple']['users'][1]['nickname'],
  //         period: {
  //           'start': lastMonday,
  //           'end': lastSunday,
  //         },
  //       ),
  //     );
  //   } catch (e) {
  //     return ResponseDto(
  //       success: false,
  //       message: "Server Error: ${e.toString()}",
  //     );
  //   }
  // }

  // @override
  // Future<void> completeHardCarry(String userId) async {
  //   try {
  //     await _client
  //         .from('User')
  //         .update({'isShowHardCarry': true}).eq('deviceId', userId);
  //   } catch (e) {
  //     throw Exception('Failed to complete hardcarry: ${e.toString()}');
  //   }
  // }
}

@riverpod
MakeVocabularySupabaseDataSource makeVocabularySupabaseDataSource(MakeVocabularySupabaseDataSourceRef ref) {
  return MakeVocabularySupabaseDataSource(ref.watch(supabaseProvider));
}
