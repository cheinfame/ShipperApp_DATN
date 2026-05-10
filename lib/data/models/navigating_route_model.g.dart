// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigating_route_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NavigatingRoute _$NavigatingRouteFromJson(Map<String, dynamic> json) =>
    NavigatingRoute(
      route: Route.fromJson(json['route'] as Map<String, dynamic>),
      ordersFromRoute: (json['ordersFromRoute'] as List<dynamic>)
          .map((e) => OrderWithInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      isInUse: json['isInUse'] as bool,
    );

Map<String, dynamic> _$NavigatingRouteToJson(NavigatingRoute instance) =>
    <String, dynamic>{
      'route': instance.route,
      'ordersFromRoute': instance.ordersFromRoute,
      'isInUse': instance.isInUse,
    };
