import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:packare_shipper/data/models/account_model.dart';
import 'package:packare_shipper/data/models/order_model.dart';
import 'package:packare_shipper/data/models/route_model.dart';
import 'package:packare_shipper/data/repositories/map_repository_impl.dart';
import 'package:packare_shipper/data/repositories/order_repository_impl.dart';
import 'package:packare_shipper/data/repositories/shipping_repository_impl.dart';
import 'package:packare_shipper/locator.dart';
import 'package:packare_shipper/presentation/routes/view_model/routes_state.dart';

final routesViewModelProvider =
    StateNotifierProvider.family<RoutesViewModel, RoutesState, Account>(
  (ref, shipperAccount) => RoutesViewModel(
    ref: ref,
    mapRepository: locator<MapRepositoryImpl>(),
    shippingRepository: locator<ShippingRepositoryImpl>(),
    shipperAccount: shipperAccount,
  ),
);

class RoutesViewModel extends StateNotifier<RoutesState> {
  RoutesViewModel({
    required this.ref,
    required this.mapRepository,
    required this.shipperAccount,
    required this.shippingRepository,
  }) : super(const RoutesState()) {
    getRoutes();
  }

  final Ref ref;
  final MapRepositoryImpl mapRepository;
  final ShippingRepositoryImpl shippingRepository;
  final Account shipperAccount;

  Future<void> getRoutes() async {
    try {
      state = state.copyWith(isLoading: true);

      final List<Route> routes = await mapRepository
          .getShipperRoutes(shipperAccount.shipper!.shipperId);

      state = state.copyWith(isLoading: false, routes: routes);
    } catch (e) {
      state = state.copyWith(isLoading: false, routes: []);
      rethrow;
    }
  }

  Future<void> saveRoute(Route route) async {
    try {
      state = state.copyWith(isLoading: true);

      await mapRepository.saveRoute(route);

      final List<Route> updatedRoutes = await mapRepository
          .getShipperRoutes(shipperAccount.shipper!.shipperId);


      state = state.copyWith(isLoading: false, routes: updatedRoutes);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteRoute(String routeId) async {
    try {
      state = state.copyWith(isLoading: true);

      await mapRepository.deleteRouteById(routeId);

      final List<Route> updatedRoutes = await mapRepository
          .getShipperRoutes(shipperAccount.shipper!.shipperId);

      state = state.copyWith(isLoading: false, routes: updatedRoutes);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateRoute(Route updatedRoute) async {
    try {
      List<OrderWithInfo> currentOrders = await shippingRepository
          .getCurrentOrders(shipperAccount.shipper!.shipperId);

      for (OrderWithInfo order in currentOrders) {
        if (order.shipperRouteId == updatedRoute.routeId) {
          throw ('Cannot update route with active orders');
        }
      }

      await mapRepository.updateRouteById(updatedRoute.routeId!, updatedRoute);

      final List<Route> updatedRoutes = await mapRepository
          .getShipperRoutes(shipperAccount.shipper!.shipperId);

      state = state.copyWith(routes: updatedRoutes);
    } catch (e) {
      rethrow;
    }
  }
}
