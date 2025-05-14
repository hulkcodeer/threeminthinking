import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:threeminthinking/core/uitils/device_key.dart';
import 'package:threeminthinking/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:threeminthinking/features/splash/domain/entities/user_info_entity.dart';
import 'package:threeminthinking/features/splash/domain/repositories/splash_repository.dart';
import 'package:threeminthinking/features/splash/presentation/viewmodels/splash_state.dart';
import 'package:threeminthinking/features/splash/data/dtos/user_info_dto.dart';

part 'splash_viewmodel.g.dart';

@riverpod
class SplashViewModel extends _$SplashViewModel {
  late final SplashRepository _repository;

  @override
  Future<SplashState> build() async {
    _repository = ref.watch(splashRepositoryProvider);

    return const SplashState.initial();
  }

  Future<void> checkUserInfo() async {
    state = const AsyncData(SplashState.loading());
    try {
      final localUserInfo = await _repository.getLocalUserInfo();
      if (localUserInfo == null) {
        final deviceId = await getDeviceUniqueId();
        final response = await _repository.getUserInfoByDeviceId(deviceId);

        if (response.success) {
          final userInfo = response.data;
          await _repository.saveUserInfo(userInfo?.toEntity() ?? UserInfoEntity.empty());
          state = const AsyncData(SplashState.authenticated());
        } else {
          state = const AsyncData(SplashState.unauthenticated());
        }
      } else {
        state = const AsyncData(SplashState.authenticated());
      }
    } catch (e) {
      print(e.toString());
      state = AsyncData(SplashState.error(e.toString()));
    }
  }
}
