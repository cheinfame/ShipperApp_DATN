import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:packare_shipper/data/models/route_model.dart';
import 'package:packare_shipper/data/repositories/map_repository_impl.dart';
import 'package:packare_shipper/presentation/create_route/view_model/create_route_state.dart';
import 'package:packare_shipper/presentation/routes/view_model/routes_view_model.dart';
import 'package:packare_shipper/shared/account_view_model/account_view_model.dart';

class CreateRouteViewModel extends StateNotifier<CreateRouteState> {
  CreateRouteViewModel({required this.ref, required this.mapRepository})
      : super(CreateRouteState());

  final Ref ref;

  final MapRepositoryImpl mapRepository;

  void setStartCoords(LatLng? startCoords) {
    state = state.copyWith(startCoords: startCoords);
  }

  void setEndCoords(LatLng? endCoords) {
    state = state.copyWith(endCoords: endCoords);
  }

  Future<void> createRoute() async {
    try {
      if (state.startCoords != null && state.endCoords != null) {
        Route newRoute = await mapRepository.createRoute(
            startCoords: state.startCoords!, endCoords: state.endCoords!);
    
        state = state.copyWith(
          geometry: newRoute.geometry,
          createdRoute: newRoute,
        );
      }
    } catch (e) {
      rethrow;
    }
    print(state.geometry);
  }

  void setGeometry(List<List<double>> geometry) {
    state = state.copyWith(geometry: geometry);
  }

  Future<void> saveRoute(Route route) async {
    try {
      state = state.copyWith(isLoading: true);

      final shipperAccount = ref.read(accountViewModelProvider);

      route = route.copyWith(shipperId: shipperAccount!.shipper!.shipperId);

      ref.read(routesViewModelProvider(shipperAccount).notifier).saveRoute(route);

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }
}
