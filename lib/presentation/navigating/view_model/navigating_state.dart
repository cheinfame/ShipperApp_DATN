import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:packare_shipper/data/models/navigating_route_model.dart';
import 'package:packare_shipper/data/models/order_model.dart';
import 'package:packare_shipper/data/models/route_model.dart';

part 'navigating_state.freezed.dart';

@freezed
class NavigatingState with _$NavigatingState {
  const factory NavigatingState({
      @Default(false) bool isLoading,
      @Default([]) List<NavigatingRoute> navigatingRoutes,
      NavigatingRoute? currentNavigatingRoute,
      List<OrderWithInfo>? currentPickingUpOrders,
      List<OrderWithInfo>? currentDeliveringOrders,
      RouteDirection? currentNavigatingRouteDirection,
    }) = _NavigatingState;

}