import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:packare_shipper/data/models/account_model.dart';
import 'package:packare_shipper/data/models/order_model.dart';
import 'package:packare_shipper/presentation/authentication/screens/authentication_screen.dart';
import 'package:packare_shipper/presentation/main_screen.dart';
import 'package:packare_shipper/presentation/map/map_screen.dart';
import 'package:packare_shipper/presentation/navigating/navigating_screen.dart';
import 'package:packare_shipper/presentation/onboarding/onboarding_screen.dart';
import 'package:packare_shipper/presentation/orders/screens/order_detail_screen.dart';
import 'package:packare_shipper/presentation/profile_screens/screens/change_password_screen.dart';
import 'package:packare_shipper/presentation/profile_screens/screens/config_max_distance_allowance_screen.dart';
import 'package:packare_shipper/presentation/profile_screens/screens/user_info_screen.dart';
import 'package:packare_shipper/presentation/profile_screens/screens/user_profile_screen.dart';
import 'package:packare_shipper/presentation/create_route/create_route_screen.dart';
import 'package:packare_shipper/presentation/routes/routes_screen.dart';
import 'package:packare_shipper/presentation/splash/splash_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          path: '/',
          initial: true,
        ),
        AutoRoute(
          page: OnboardingRoute.page,
          path: '/onboarding',
        ),
        AutoRoute(
          page: AuthenticationRoute.page,
          path: '/auth',
        ),
        AutoRoute(
          page: MainRoute.page,
          path: '/home',
        ),
        CustomRoute(
          page: NavigatingRoute.page,
          path: '/navigating',
          transitionsBuilder: TransitionsBuilders.slideBottom,
        ),
        AutoRoute(
          page: MapRoute.page,
          path: '/map',
        ),
        AutoRoute(
          page: RoutesRoute.page,
          path: '/routes',
        ),
        AutoRoute(
          page: OrderDetailRoute.page,
          path: '/order-detail',
        ),
        AutoRoute(
          page: ChangePasswordRoute.page,
          path: '/change-password',
        ),
        AutoRoute(
          page: ConfigMaxDistanceAllowanceRoute.page,
          path: '/config-max-distance',
        ),
        AutoRoute(
          page: UserInfoRoute.page,
          path: '/user-info',
        ),
        AutoRoute(
          page: UserProfileRoute.page,
          path: '/user-profile',
        ),
        AutoRoute(
          page: CreateRouteRoute.page,
          path: '/create-route',
        ),
      ];
}
