// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderWithInfo _$OrderWithInfoFromJson(Map<String, dynamic> json) =>
    OrderWithInfo(
      order: Order.fromJson(json['order'] as Map<String, dynamic>),
      distance: (json['distance'] as num).toDouble(),
      orderGeometry: (json['orderGeometry'] as List<dynamic>)
          .map((e) =>
              (e as List<dynamic>).map((e) => (e as num).toDouble()).toList())
          .toList(),
      shipperRouteId: json['shipperRouteId'] as String,
    );

Map<String, dynamic> _$OrderWithInfoToJson(OrderWithInfo instance) =>
    <String, dynamic>{
      'order': instance.order,
      'distance': instance.distance,
      'orderGeometry': instance.orderGeometry,
      'shipperRouteId': instance.shipperRouteId,
    };

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      shipper: json['shipper'] == null
          ? null
          : Account.fromJson(json['shipper'] as Map<String, dynamic>),
      sender: json['sender'] == null
          ? null
          : Account.fromJson(json['sender'] as Map<String, dynamic>),
      shipperRoute: json['shipperRoute'] == null
          ? null
          : Route.fromJson(json['shipperRoute'] as Map<String, dynamic>),
      orderId: json['order_id'] as String,
      packages: (json['packages'] as List<dynamic>)
          .map((e) => Package.fromJson(e as Map<String, dynamic>))
          .toList(),
      feedback: json['feedback'] == null
          ? null
          : OrderFeedback.fromJson(json['feedback'] as Map<String, dynamic>),
      senderId: json['sender_id'] as String,
      shipperId: json['shipper_id'] as String?,
      receiverName: json['receiver_name'] as String,
      receiverPhone: json['receiver_phone'] as String,
      shippingPrice: (json['shipping_price'] as num?)?.toDouble(),
      sendAddress: json['send_address'] as String,
      sendCoordinates:
          GeoJson.fromJson(json['send_coordinates'] as Map<String, dynamic>),
      deliveryAddress: json['delivery_address'] as String,
      deliveryCoordinates: GeoJson.fromJson(
          json['delivery_coordinates'] as Map<String, dynamic>),
      createTime: json['create_time'] == null
          ? null
          : DateTime.parse(json['create_time'] as String),
      status: Order._orderStatusFromJson(json['status'] as String),
      statusChangeTime: json['status_change_time'] == null
          ? null
          : DateTime.parse(json['status_change_time'] as String),
      preferredPickupStartTime: json['preferred_pickup_start_time'] == null
          ? null
          : DateTime.parse(json['preferred_pickup_start_time'] as String),
      preferredPickupEndTime: json['preferred_pickup_end_time'] == null
          ? null
          : DateTime.parse(json['preferred_pickup_end_time'] as String),
      preferredDeliveryStartTime: json['preferred_delivery_start_time'] == null
          ? null
          : DateTime.parse(json['preferred_delivery_start_time'] as String),
      preferredDeliveryEndTime: json['preferred_delivery_end_time'] == null
          ? null
          : DateTime.parse(json['preferred_delivery_end_time'] as String),
      orderLastingTime: json['order_lasting_time'] == null
          ? null
          : DateTime.parse(json['order_lasting_time'] as String),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'shipper': instance.shipper,
      'sender': instance.sender,
      'shipperRoute': instance.shipperRoute,
      'order_id': instance.orderId,
      'packages': instance.packages,
      'feedback': instance.feedback,
      'sender_id': instance.senderId,
      'shipper_id': instance.shipperId,
      'receiver_name': instance.receiverName,
      'receiver_phone': instance.receiverPhone,
      'shipping_price': instance.shippingPrice,
      'send_address': instance.sendAddress,
      'send_coordinates': instance.sendCoordinates,
      'delivery_address': instance.deliveryAddress,
      'delivery_coordinates': instance.deliveryCoordinates,
      'create_time': instance.createTime?.toIso8601String(),
      'status': Order.orderStatusToJson(instance.status),
      'status_change_time': instance.statusChangeTime?.toIso8601String(),
      'preferred_pickup_start_time':
          instance.preferredPickupStartTime?.toIso8601String(),
      'preferred_pickup_end_time':
          instance.preferredPickupEndTime?.toIso8601String(),
      'preferred_delivery_start_time':
          instance.preferredDeliveryStartTime?.toIso8601String(),
      'preferred_delivery_end_time':
          instance.preferredDeliveryEndTime?.toIso8601String(),
      'order_lasting_time': instance.orderLastingTime?.toIso8601String(),
    };
