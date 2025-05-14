import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:threeminthinking/features/home/data/repositories/home_repository_impl.dart';
import 'package:threeminthinking/features/home/domain/repositories/home_repository.dart';
import 'package:threeminthinking/features/home/presentation/viewmodels/home_state.dart';

part 'home_viewmodel.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  late final HomeRepository _repository;

  @override
  Future<HomeState> build() async {
    _repository = ref.watch(homeRepositoryProvider);

    return HomeState();
  }
}
