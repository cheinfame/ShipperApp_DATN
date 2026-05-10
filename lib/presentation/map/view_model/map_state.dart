import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../../data/models/order_model.dart';

part 'map_state.freezed.dart';

@freezed
class MapState with _$MapState {
  factory MapState({
    @Default(false) bool isLoading,
    Position? currentPosition,
    @Default(LatLng(0, 0)) LatLng centerCoords,
    @Default([]) List<List<double>> geometry,
    @Default([]) List<LatLng> waypoints,
    @Default(null) LatLng? startCoords,
    @Default(null) LatLng? endCoords,
    @Default(13.0) double zoomLevel,

    OrderWithInfo? currentViewingOrder,
    @Default(false) bool isNavigating,
  }) = _MapState;
}
