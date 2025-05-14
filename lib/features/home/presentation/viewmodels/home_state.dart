import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

enum MenuType {
  weTodo('우리의 할일'), // 우리의 할일
  myTodo('나의 할일'), // 나의 할일
  shopping('살것'), // 살것
  meal('식단표'), // 식단표
  fairy('zip요정'); // zip요정

  final String description;
  const MenuType(this.description);
}

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(MenuType.weTodo) MenuType selectedMenu,
    String? error,
    @Default(false) bool isSubscribed,
  }) = _HomeState;
}
