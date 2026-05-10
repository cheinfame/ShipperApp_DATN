// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AuthenticationScreen]
class AuthenticationRoute extends PageRouteInfo<AuthenticationRouteArgs> {
  AuthenticationRoute({
    Key? key,
    String? error,
    List<PageRouteInfo>? children,
  }) : super(
          AuthenticationRoute.name,
          args: AuthenticationRouteArgs(
            key: key,
            error: error,
          ),
          initialChildren: children,
        );

  static const String name = 'AuthenticationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AuthenticationRouteArgs>(
          orElse: () => const AuthenticationRouteArgs());
      return AuthenticationScreen(
        key: args.key,
        error: args.error,
      );
    },
  );
}

class AuthenticationRouteArgs {
  const AuthenticationRouteArgs({
    this.key,
    this.error,
  });

  final Key? key;

  final String? error;

  @override
  String toString() {
    return 'AuthenticationRouteArgs{key: $key, error: $error}';
  }
}

/// generated route for
/// [ChangePasswordScreen]
class ChangePasswordRoute extends PageRouteInfo<void> {
  const ChangePasswordRoute({List<PageRouteInfo>? children})
      : super(
          ChangePasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangePasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ChangePasswordScreen();
    },
  );
}

/// generated route for
/// [ConfigMaxDistanceAllowanceScreen]
class ConfigMaxDistanceAllowanceRoute extends PageRouteInfo<void> {
  const ConfigMaxDistanceAllowanceRoute({List<PageRouteInfo>? children})
      : super(
          ConfigMaxDistanceAllowanceRoute.name,
          initialChildren: children,
        );

  static const String name = 'ConfigMaxDistanceAllowanceRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ConfigMaxDistanceAllowanceScreen();
    },
  );
}

/// generated route for
/// [CreateRouteScreen]
class CreateRouteRoute extends PageRouteInfo<void> {
  const CreateRouteRoute({List<PageRouteInfo>? children})
      : super(
          CreateRouteRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateRouteRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CreateRouteScreen();
    },
  );
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainScreen();
    },
  );
}

/// generated route for
/// [MapScreen]
class MapRoute extends PageRouteInfo<MapRouteArgs> {
  MapRoute({
    Key? key,
    OrderWithInfo? orderInfo,
    bool isNavigating = false,
    List<PageRouteInfo>? children,
  }) : super(
          MapRoute.name,
          args: MapRouteArgs(
            key: key,
            orderInfo: orderInfo,
            isNavigating: isNavigating,
          ),
          initialChildren: children,
        );

  static const String name = 'MapRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<MapRouteArgs>(orElse: () => const MapRouteArgs());
      return MapScreen(
        key: args.key,
        orderInfo: args.orderInfo,
        isNavigating: args.isNavigating,
      );
    },
  );
}

class MapRouteArgs {
  const MapRouteArgs({
    this.key,
    this.orderInfo,
    this.isNavigating = false,
  });

  final Key? key;

  final OrderWithInfo? orderInfo;

  final bool isNavigating;

  @override
  String toString() {
    return 'MapRouteArgs{key: $key, orderInfo: $orderInfo, isNavigating: $isNavigating}';
  }
}

/// generated route for
/// [NavigatingScreen]
class NavigatingRoute extends PageRouteInfo<void> {
  const NavigatingRoute({List<PageRouteInfo>? children})
      : super(
          NavigatingRoute.name,
          initialChildren: children,
        );

  static const String name = 'NavigatingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NavigatingScreen();
    },
  );
}

/// generated route for
/// [OnboardingScreen]
class OnboardingRoute extends PageRouteInfo<void> {
  const OnboardingRoute({List<PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OnboardingScreen();
    },
  );
}

/// generated route for
/// [OrderDetailScreen]
class OrderDetailRoute extends PageRouteInfo<OrderDetailRouteArgs> {
  OrderDetailRoute({
    Key? key,
    required Order order,
    List<PageRouteInfo>? children,
  }) : super(
          OrderDetailRoute.name,
          args: OrderDetailRouteArgs(
            key: key,
            order: order,
          ),
          initialChildren: children,
        );

  static const String name = 'OrderDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OrderDetailRouteArgs>();
      return OrderDetailScreen(
        key: args.key,
        order: args.order,
      );
    },
  );
}

class OrderDetailRouteArgs {
  const OrderDetailRouteArgs({
    this.key,
    required this.order,
  });

  final Key? key;

  final Order order;

  @override
  String toString() {
    return 'OrderDetailRouteArgs{key: $key, order: $order}';
  }
}

/// generated route for
/// [RoutesScreen]
class RoutesRoute extends PageRouteInfo<void> {
  const RoutesRoute({List<PageRouteInfo>? children})
      : super(
          RoutesRoute.name,
          initialChildren: children,
        );

  static const String name = 'RoutesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RoutesScreen();
    },
  );
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashScreen();
    },
  );
}

/// generated route for
/// [UserInfoScreen]
class UserInfoRoute extends PageRouteInfo<void> {
  const UserInfoRoute({List<PageRouteInfo>? children})
      : super(
          UserInfoRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserInfoRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const UserInfoScreen();
    },
  );
}

/// generated route for
/// [UserProfileScreen]
class UserProfileRoute extends PageRouteInfo<void> {
  const UserProfileRoute({List<PageRouteInfo>? children})
      : super(
          UserProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const UserProfileScreen();
    },
  );
}
