import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:packare_shipper/data/models/order_model.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool isLoading,
    @Default([]) List<OrderWithInfo> availableOrders,
    @Default({}) Map<String, String> routeNamesMap,
  }) = _HomeState;
}
