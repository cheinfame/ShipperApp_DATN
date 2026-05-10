import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

import '../../../data/models/route_model.dart';

part 'create_route_state.freezed.dart';

@freezed
class CreateRouteState with _$CreateRouteState {
  const factory CreateRouteState({
    @Default(false) bool isLoading,
    LatLng? startCoords,
    LatLng? endCoords,
    @Default([]) List<List<double>> geometry,
    Route? createdRoute,
  }) = _CreateRouteState;
}
