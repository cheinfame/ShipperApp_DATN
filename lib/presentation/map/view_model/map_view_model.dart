import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:packare_shipper/data/services/local/shared_preferences_service.dart';
import 'package:packare_shipper/locator.dart';
import 'package:packare_shipper/utils/distance_calculator.dart';
import 'package:packare_shipper/utils/location_handler.dart';

import 'map_state.dart';

final mapViewModelProvider = StateNotifierProvider<MapViewModel, MapState>(
  (ref) => MapViewModel(
    sharedPreferencesService: locator<SharedPreferencesService>(),
  ),
);

class MapViewModel extends StateNotifier<MapState> {
  MapViewModel({required this.sharedPreferencesService}) : super(MapState()) {
    updateCenterCoords();
  }

  final SharedPreferencesService sharedPreferencesService;

  Future<bool> checkLocationPermission() async {
    state = state.copyWith(isLoading: true);
    bool granted =
        sharedPreferencesService.getBoolValue('location_permission') ?? false;

    if (!granted) {
      granted = await requestLocationPermission();
      sharedPreferencesService.setBoolValue('location_permission', granted);
    }

    state = state.copyWith(isLoading: false);
    return granted;
  }

  /// Update the map's center coordinates
  void updateCenterCoords() async {
    final startCoords = state.startCoords;
    final endCoords = state.endCoords;

    LatLng centerCoords;

    double zoomLevel = 14;

    if (startCoords == null && endCoords == null) {
      Position currentPosition = await Geolocator.getCurrentPosition();

      centerCoords =
          LatLng(currentPosition.latitude, currentPosition.longitude);

      state = state.copyWith(
        centerCoords: centerCoords,
        zoomLevel: zoomLevel,
      );

      return;
    }

    if (startCoords != null && endCoords != null) {
      final distance = calculateDistance(startCoords, endCoords);
      zoomLevel = _calculateZoomLevel(distance);
      centerCoords = LatLng(
        (startCoords.latitude + endCoords.latitude) / 2,
        (startCoords.longitude + endCoords.longitude) / 2,
      );
    } else {
      centerCoords = startCoords ?? endCoords!;
    }

    state = state.copyWith(
      centerCoords: centerCoords,
      zoomLevel: zoomLevel,
    );
  }

  /// Set waypoints for the map
  void setWaypoints(List<LatLng> waypoints) {
    state = state.copyWith(waypoints: waypoints);
  }

  /// Set geometry for a route
  void setRouteGeometry(List<List<double>> geometry) {
    state = state.copyWith(geometry: geometry);
  }

  /// Update start and end coordinates
  void setStartAndEndCoords(LatLng? start, LatLng? end) {
    state = state.copyWith(
      startCoords: start,
      endCoords: end,
    );
  }

  double _calculateZoomLevel(double distance) {
    if (distance < 100) return 18.0;
    if (distance < 200) return 17.0;
    if (distance < 500) return 16.0;
    if (distance < 1000) return 15.5;
    if (distance < 2000) return 14.5;
    if (distance < 5000) return 13.5;
    if (distance < 10000) return 12.5;
    if (distance < 20000) return 11.5;
    return 11.0;
  }
}
