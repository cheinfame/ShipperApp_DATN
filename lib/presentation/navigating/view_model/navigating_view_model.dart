import 'dart:convert';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:packare_shipper/data/models/account_model.dart';
import 'package:packare_shipper/data/models/navigating_route_model.dart';
import 'package:packare_shipper/data/models/order_model.dart';
import 'package:packare_shipper/data/models/route_model.dart';
import 'package:packare_shipper/data/repositories/map_repository_impl.dart';
import 'package:packare_shipper/data/repositories/shipping_repository_impl.dart';
import 'package:packare_shipper/data/services/local/shared_preferences_service.dart';
import 'package:packare_shipper/presentation/navigating/view_model/navigating_state.dart';
import 'package:packare_shipper/presentation/orders/view_model/orders_view_model.dart';
import 'package:packare_shipper/shared/account_view_model/account_view_model.dart';
import 'package:packare_shipper/data/services/foreground/location_task_handler.dart';

class NavigatingViewModel extends StateNotifier<NavigatingState> {
  NavigatingViewModel({
    required this.ref,
    required this.shippingRepository,
    required this.mapRepository,
    required this.sharedPreferencesService,
  }) : super(NavigatingState()) {
    getNavigatingRoutes();
  }

  final Ref ref;
  final ShippingRepositoryImpl shippingRepository;
  final MapRepositoryImpl mapRepository;
  final SharedPreferencesService sharedPreferencesService;

  Account? get shipperAccount => ref.watch(accountViewModelProvider);

  void setupCurrentNavigatingRoute() {
    final String? currentNavigatingRouteId =
        sharedPreferencesService.getStringValue('currentNavigatingRouteId');

    final String? currentNavigatingRouteDirection = sharedPreferencesService
        .getStringValue('currentNavigatingRouteDirection');

    if (currentNavigatingRouteId != null &&
        currentNavigatingRouteDirection != null) {
      final NavigatingRoute navigatingRoute = state.navigatingRoutes.firstWhere(
        (route) => route.route.routeId == currentNavigatingRouteId,
      );

      setCurrentNavigatingRoute(navigatingRoute);
      setCurrentNavigatingRouteDirection(
          stringToRouteDirection(currentNavigatingRouteDirection));
    }
  }

  Future<void> confirmPickedUpOrder(OrderWithInfo order) async {
    try {
      state = state.copyWith(isLoading: true);

      await ref
          .read(ordersViewModelProvider.notifier)
          .confirmPickedUpOrder(order.order.orderId);

      List<OrderWithInfo> currentPickingUpOrders =
          List.from(state.currentPickingUpOrders ?? []);

      currentPickingUpOrders
          .removeWhere((o) => o.order.orderId == order.order.orderId);

      List<OrderWithInfo> currentDeliveringOrders =
          List.from(state.currentDeliveringOrders ?? []);

      currentDeliveringOrders.add(order);

      state = state.copyWith(
        currentPickingUpOrders: currentPickingUpOrders,
        currentDeliveringOrders: currentDeliveringOrders,
      );

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }

  Future<void> confirmDeliveredOrder(OrderWithInfo order) async {
    try {
      state = state.copyWith(isLoading: true);

      await ref
          .read(ordersViewModelProvider.notifier)
          .confirmDeliveredOrder(order.order.orderId);

      List<OrderWithInfo> currentDeliveringOrders =
          List.from(state.currentDeliveringOrders ?? []);

      currentDeliveringOrders
          .removeWhere((o) => o.order.orderId == order.order.orderId);

      // Remove from foreground service
      List<String> updatedOrderIds =
          currentDeliveringOrders.map((o) => o.order.orderId).toList();
      await FlutterForegroundTask.saveData(
        key: 'orderIds',
        value: jsonEncode(updatedOrderIds),
      );

      if (updatedOrderIds.isEmpty) {
        stopLocationSharingForegroundService();
      }

      if (currentDeliveringOrders.isEmpty) {
        if (state.currentPickingUpOrders == null ||
            state.currentPickingUpOrders!.isEmpty) {
          clearCurrentNavigatingRoute();
          clearCurrentNavigatingRouteDirection();
        }
      }

      state = state.copyWith(
          isLoading: false, currentDeliveringOrders: currentDeliveringOrders);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }

  Future<void> getNavigatingRoutes() async {
    try {
      state = state.copyWith(isLoading: true);

      final List<OrderWithInfo> currentOrders = await shippingRepository
          .getCurrentOrders(shipperAccount!.shipper!.shipperId);

      final Set<String> routeIds =
          currentOrders.map((order) => order.shipperRouteId).toSet();

      List<NavigatingRoute> navigatingRoutes = [];

      for (String routeId in routeIds) {
        final route = await mapRepository.getRouteById(routeId);
        final matchingOrders = currentOrders
            .where(
              (orderInfo) =>
                  orderInfo.shipperRouteId == routeId &&
                  orderInfo.order.status != OrderStatus.delivered &&
                  orderInfo.order.status != OrderStatus.shipperAccepted,
            )
            .toList();

        if (matchingOrders.isEmpty) {
          continue;
        }

        navigatingRoutes.add(
          NavigatingRoute(
            route: route,
            ordersFromRoute: matchingOrders,
            isInUse: false,
          ),
        );
      }

      state = state.copyWith(
        isLoading: false,
        navigatingRoutes: navigatingRoutes,
      );
      setupCurrentNavigatingRoute();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setCurrentNavigatingRoute(
      NavigatingRoute navigatingRoute) async {
    try {
      List<OrderWithInfo> currentPickingUpOrders = navigatingRoute
          .ordersFromRoute
          .where((order) => order.order.status == OrderStatus.startShipping)
          .toList();

      List<OrderWithInfo> currentDeliveringOrders = navigatingRoute
          .ordersFromRoute
          .where((order) => order.order.status == OrderStatus.shipperPickedUp)
          .toList();

      if (currentPickingUpOrders.isEmpty && currentDeliveringOrders.isEmpty) {
        clearCurrentNavigatingRoute();
        clearCurrentNavigatingRouteDirection();
        return;
      }

      await sharedPreferencesService.setStringValue(
          'currentNavigatingRouteId', navigatingRoute.route.routeId!);

      state = state.copyWith(
        currentNavigatingRoute: navigatingRoute,
        currentPickingUpOrders: currentPickingUpOrders,
        currentDeliveringOrders: currentDeliveringOrders,
      );

      // Collect all order IDs
      List<String> allOrderIds = [
        ...currentPickingUpOrders.map((o) => o.order.orderId),
        ...currentDeliveringOrders.map((o) => o.order.orderId),
      ];

      if (allOrderIds.isNotEmpty) {
        await startLocationSharingForegroundService(
            shipperAccount!.shipper!.shipperId, allOrderIds);
      }

    } catch (e) {
      rethrow;
    }
  }

  void clearCurrentNavigatingRoute() {
    state = state.copyWith(currentNavigatingRoute: null);
    sharedPreferencesService.removeValue('currentNavigatingRouteId');

    // Stop the foreground service when no route is selected
    stopLocationSharingForegroundService();

    // Get the routes again for the user to select a new route
    getNavigatingRoutes();
  }

  void setCurrentNavigatingRouteDirection(RouteDirection routeDirection) {
    state = state.copyWith(currentNavigatingRouteDirection: routeDirection);
    sharedPreferencesService.setStringValue('currentNavigatingRouteDirection',
        routeDirectionToString(routeDirection));
  }

  void clearCurrentNavigatingRouteDirection() {
    state = state.copyWith(currentNavigatingRouteDirection: null);
    sharedPreferencesService.removeValue('currentNavigatingRouteDirection');
  }

  Future<ServiceRequestResult> startLocationSharingForegroundService(
      String shipperId, List<String> orderIds) async {
    await FlutterForegroundTask.saveData(
      key: 'shipperId',
      value: shipperId,
    );
    await FlutterForegroundTask.saveData(
      key: 'orderIds',
      value: jsonEncode(orderIds),
    );

    if (await FlutterForegroundTask.isRunningService) {
      return FlutterForegroundTask.restartService();
    } else {
      return FlutterForegroundTask.startService(
        serviceId: 256,
        notificationTitle: 'Packare Shipper',
        notificationText: 'Location sharing is active',
        notificationInitialRoute: '/navigating',
        callback: startLocationSharingTaskCallback,
      );
    }
  }

  // Stop the location sharing service
  void stopLocationSharingForegroundService() async {
    try {
      await FlutterForegroundTask.stopService();
    } catch (e) {
      print("Error stopping foreground service: $e");
    }
  }
}
