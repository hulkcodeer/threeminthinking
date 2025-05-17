import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

enum MenuType {
  wordbook('단어장'), // 단어장
  calendar('캘린더'); // 캘린더

  final String description;
  const MenuType(this.description);
}

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(MenuType.wordbook) MenuType selectedMenu,
    String? error,
    @Default(false) bool isSubscribed,
  }) = _HomeState;
}
