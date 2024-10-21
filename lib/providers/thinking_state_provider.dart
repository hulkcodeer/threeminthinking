import 'package:riverpod/riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'thinking_state_provider.freezed.dart';
part 'thinking_state_provider.g.dart';

final thinkingStateProvider =
    StateNotifierProvider<ThinkingStateNotifier, ThinkingState>((ref) {
  return ThinkingStateNotifier();
});

@freezed
class ThinkingState with _$ThinkingState {
  const factory ThinkingState({
    @Default(180) int timeLeft,
    @Default(false) bool showStartModal,
    @Default(false) bool showEndModal,
    @Default("") String thinkingDesc,
    @Default(false) bool isTimerRunning,
    @Default(false) bool showHint,
    @Default("") String currentHint,
    @Default(false) bool isEditable,
  }) = _ThinkingState;

  factory ThinkingState.fromJson(Map<String, dynamic> json) =>
      _$ThinkingStateFromJson(json);
}

class ThinkingStateNotifier extends StateNotifier<ThinkingState> {
  ThinkingStateNotifier() : super(const ThinkingState());

  void updateThinkingDesc(String desc) {
    state = state.copyWith(thinkingDesc: desc);
  }

  void setShowStartModal(bool show) {
    if (state.showStartModal != show) {
      state = state.copyWith(showStartModal: show);
    }
  }

  void setShowEndModal(bool show) {
    if (state.showEndModal != show) {
      state = state.copyWith(showEndModal: show);
    }
  }

  void setIsTimerRunning(bool isRunning) {
    state = state.copyWith(isTimerRunning: isRunning);
  }

  void setTimeLeft(int time) {
    state = state.copyWith(timeLeft: time);
  }

  void setShowHint(bool show) {
    state = state.copyWith(showHint: show);
  }

  void setCurrentHint(String hint) {
    state = state.copyWith(currentHint: hint);
  }

  void setIsEditable(bool isEditable) {
    state = state.copyWith(isEditable: isEditable);
  }

  void handleStartConfirm() {
    state = state.copyWith(
      showStartModal: false,
      isTimerRunning: true,
      isEditable: true,
    );
  }

  void handleEndConfirm() {
    state = state.copyWith(
      showEndModal: false,
      isTimerRunning: false,
      isEditable: false,
    );
  }

  void resetState() {
    state = ThinkingState();
  }
}
