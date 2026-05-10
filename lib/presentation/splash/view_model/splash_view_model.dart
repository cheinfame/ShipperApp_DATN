import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:packare_shipper/data/repositories/auth_repository_impl.dart';
import 'package:packare_shipper/data/services/local/shared_preferences_service.dart';
import 'package:packare_shipper/shared/account_view_model/account_view_model.dart';
import 'splash_state.dart';

class SplashViewModel extends StateNotifier<SplashState> {
  SplashViewModel({
    required this.ref,
    required this.authRepository,
    required this.sharedPreferencesService,
  }) : super(const SplashState());

  final AuthRepositoryImpl authRepository;
  final SharedPreferencesService sharedPreferencesService;

  final Ref ref;

  Future<void> initData() async {
    try {
      state = state.copyWith(isLoading: true);

      // First time open app check
      final isFirstTimeOpenApp =
          sharedPreferencesService.getBoolValue('isFirstTimeOpenApp') ?? true;

      if (isFirstTimeOpenApp) {
        state = state.copyWith(
          isLoading: false,
          isFirstTimeOpenApp: isFirstTimeOpenApp,
        );

        sharedPreferencesService.setBoolValue('isFirstTimeOpenApp', false);
        return;
      }

      // Cache Login check
      final isLoggedIn =
          sharedPreferencesService.getBoolValue('isLoggedIn') ?? false;
      if (isLoggedIn) {
        final account = await authRepository.loginWithCache();
        ref.read(accountViewModelProvider.notifier).setAccount(account);
      }

      final haveNavigatingRoute =
          sharedPreferencesService.getStringValue('currentNavigatingRouteId') !=
              null;

      state = state.copyWith(
        isLoading: false,
        isLoggedIn: isLoggedIn,
        isFirstTimeOpenApp: isFirstTimeOpenApp,
        haveCurrentNavigatingRoute: haveNavigatingRoute,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }
}
