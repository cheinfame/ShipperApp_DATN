import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:packare_shipper/config/path.dart';
import 'package:packare_shipper/data/repositories/auth_repository_impl.dart';
import 'package:packare_shipper/data/services/local/shared_preferences_service.dart';
import 'package:packare_shipper/locator.dart';
import 'package:packare_shipper/presentation/navigating/navigating_screen.dart';
import 'package:packare_shipper/presentation/splash/view_model/splash_state.dart';
import 'package:packare_shipper/presentation/splash/view_model/splash_view_model.dart';
import 'package:packare_shipper/router/app_router.dart';

final splashProvider = StateNotifierProvider<SplashViewModel, SplashState>(
  (ref) => SplashViewModel(
    ref: ref,
    authRepository: locator<AuthRepositoryImpl>(),
    sharedPreferencesService: locator<SharedPreferencesService>(),
  ),
);

@RoutePage()
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Delay the execution of initData to the next frame after the widget tree is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(splashProvider.notifier).initData();

      // Add a delay of 2 seconds before navigating
      Future.delayed(
        const Duration(seconds: 2),
        () {
          final splashState = ref.read(splashProvider);
          if (splashState.isFirstTimeOpenApp) {
            context.router.replaceNamed('/onboarding');
          } else if (splashState.isLoggedIn) {
            context.router.replaceNamed('/home');
            if (splashState.haveCurrentNavigatingRoute) {
              context.router.push(NavigatingRoute());
            }
          } else {
            context.router.replaceNamed('/auth');
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          warehouse_logo_path,
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}
