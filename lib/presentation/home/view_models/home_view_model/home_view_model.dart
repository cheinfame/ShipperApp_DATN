import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:packare_shipper/data/models/account_model.dart';
import 'package:packare_shipper/data/models/order_model.dart';
import 'package:packare_shipper/data/models/route_model.dart' as route_model;
import 'package:packare_shipper/data/repositories/order_repository_impl.dart';
import 'package:packare_shipper/data/repositories/shipping_repository_impl.dart';
import 'package:packare_shipper/data/repositories/user_repository_impl.dart';
import 'package:packare_shipper/presentation/routes/view_model/routes_view_model.dart';
import 'package:packare_shipper/shared/account_view_model/account_view_model.dart';
import 'package:packare_shipper/presentation/home/view_models/home_view_model/home_state.dart';

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel({
    required this.ref,
    required this.orderRepository,
    required this.shippingRepository,
    required this.userRepository,
  }) : super(const HomeState()) {
    initData();
  }

  final Ref ref;

  final OrderRepositoryImpl orderRepository;

  final ShippingRepositoryImpl shippingRepository;

  final UserRepositoryImpl userRepository;

  late Account? account;

  Future<void> initData() async {
    try {
      state = state.copyWith(isLoading: true);

      account = ref.watch(accountViewModelProvider);

      if (account == null || account!.shipper == null) {
        throw ('Failed getting user\'s info');
      }

      
      final List<OrderWithInfo> recommendedOrders =
          await shippingRepository.recommendOrdersForShipper(
        account!.shipper!.shipperId,
        account!.shipper!.maxDistanceAllowance,
      );

      List<route_model.Route> routes =
          ref.read(routesViewModelProvider(account!)).routes;

      Map<String, String> routeNames = {
        for (var route in routes) route.routeId ?? '': route.routeName ?? ''
      };

      state = state.copyWith(
        isLoading: false,
        availableOrders: recommendedOrders,
        routeNamesMap: routeNames,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }

  Future<void> acceptOrder(OrderWithInfo order, String shipperId) async {
    try {
      state = state.copyWith(isLoading: true);

      await orderRepository.acceptOrder(
        order.order.orderId,
        shipperId,
        order.shipperRouteId,
        order.orderGeometry,
        order.distance,
      );

      final List<OrderWithInfo> recommendedOrders =
          await shippingRepository.recommendOrdersForShipper(
        account!.shipper!.shipperId,
        account!.shipper!.maxDistanceAllowance,
      );

      List<route_model.Route> routes =
          ref.read(routesViewModelProvider(account!)).routes;

      Map<String, String> routeNames = {
        for (var route in routes) route.routeId ?? '': route.routeName ?? ''
      };

      state = state.copyWith(
        isLoading: false,
        availableOrders: recommendedOrders,
        routeNamesMap: routeNames,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }

  Future<void> refreshRecommendedOrders() async {
    try {
      state = state.copyWith(isLoading: true);

      final List<OrderWithInfo> recommendedOrders =
          await shippingRepository.recommendOrdersForShipper(
        account!.shipper!.shipperId,
        account!.shipper!.maxDistanceAllowance,
      );

      state = state.copyWith(
        isLoading: false,
        availableOrders: recommendedOrders,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }
}
