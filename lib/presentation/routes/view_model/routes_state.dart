import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:packare_shipper/data/models/route_model.dart';

part 'routes_state.freezed.dart';

@freezed
class RoutesState with _$RoutesState {
  const factory RoutesState({
    @Default(false) bool isLoading,
    @Default([]) List<Route> routes,
  }) = _RoutesState;
}
