// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:packare_shipper/data/models/order_model.dart';
import 'package:packare_shipper/data/models/route_model.dart';

part 'navigating_route_model.g.dart';

@JsonSerializable()
class NavigatingRoute {
  final Route route;
  final List<OrderWithInfo> ordersFromRoute;
  final bool isInUse;

  NavigatingRoute({
    required this.route,
    required this.ordersFromRoute,
    required this.isInUse,
  });

  factory NavigatingRoute.fromJson(Map<String, dynamic> json) =>
      _$NavigatingRouteFromJson(json);

  Map<String, dynamic> toJson() => _$NavigatingRouteToJson(this);

  NavigatingRoute copyWith({
    Route? route,
    List<OrderWithInfo>? ordersFromRoute,
    bool? isInUse,
  }) {
    return NavigatingRoute(
      route: route ?? this.route,
      ordersFromRoute: ordersFromRoute ?? this.ordersFromRoute,
      isInUse: isInUse ?? this.isInUse,
    );
  }
}
