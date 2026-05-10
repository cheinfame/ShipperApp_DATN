import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:packare_shipper/data/models/order_model.dart';

part 'orders_state.freezed.dart';

@freezed
class OrdersState with _$OrdersState {
  const factory OrdersState({
    @Default(false) bool isLoading,
    @Default(OrderStatus.shipperAccepted) OrderStatus currentViewingOrdersStatus,
    @Default([]) List<OrderWithInfo> currentViewingOrders,
  }) = _OrdersState;
}