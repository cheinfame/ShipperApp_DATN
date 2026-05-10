import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:packare_shipper/data/models/account_model.dart';
import 'package:packare_shipper/data/models/order_model.dart';
import 'package:packare_shipper/data/repositories/order_repository_impl.dart';
import 'package:packare_shipper/data/repositories/shipping_repository_impl.dart';
import 'package:packare_shipper/locator.dart';
import 'package:packare_shipper/shared/account_view_model/account_view_model.dart';
import 'package:packare_shipper/presentation/orders/view_model/orders_state.dart';


final ordersViewModelProvider =
    StateNotifierProvider<OrdersViewModel, OrdersState>(
  (ref) => OrdersViewModel(
    ref: ref,
    orderRepository: locator<OrderRepositoryImpl>(),
    shippingRepository: locator<ShippingRepositoryImpl>(),
  ),
);

class OrdersViewModel extends StateNotifier<OrdersState> {
  OrdersViewModel({
    required this.ref,
    required this.orderRepository,
    required this.shippingRepository,
  }) : super(const OrdersState()) {
    fetchOrders();
  }

  final Ref ref;

  final OrderRepositoryImpl orderRepository;

  final ShippingRepositoryImpl shippingRepository;

  Account? get shipperAccount => ref.watch(accountViewModelProvider);

  void setCurrentViewingOrdersType(OrderStatus viewingType) {
    state = state.copyWith(currentViewingOrdersStatus: viewingType);
  }

  Future<void> fetchOrders() async {
    try {
      state = state.copyWith(isLoading: true);

      List<OrderWithInfo> fetchedOrders =
          await shippingRepository.getShippingOrdersByStatus(
              shipperAccount!.user.userId, state.currentViewingOrdersStatus);

      state = state.copyWith(
        isLoading: false,
        currentViewingOrders: fetchedOrders,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        currentViewingOrders: [],
      );
      rethrow;
    }
  }

  Future<void> startShippingOrder(String orderId) async {
    try {
      state = state.copyWith(isLoading: true);

      await orderRepository.startShipping(orderId);

      List<OrderWithInfo> fetchedOrders =
          await shippingRepository.getShippingOrdersByStatus(
              shipperAccount!.user.userId, state.currentViewingOrdersStatus);

      state = state.copyWith(
        isLoading: false,
        currentViewingOrders: fetchedOrders,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        currentViewingOrders: [],
      );
      rethrow;
    }
  }

  Future<void> cancelOrder(String orderId) async {
    try {
      state = state.copyWith(isLoading: true);

      await orderRepository.cancelOrder(orderId);

      List<OrderWithInfo> fetchedOrders =
          await shippingRepository.getShippingOrdersByStatus(
              shipperAccount!.user.userId, state.currentViewingOrdersStatus);

      state = state.copyWith(
        isLoading: false,
        currentViewingOrders: fetchedOrders,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        currentViewingOrders: [],
      );
      rethrow;
    }
  }

  Future<void> confirmPickedUpOrder(String orderId) async {
    try {
      state = state.copyWith(isLoading: true);

      await orderRepository.confirmPickup(orderId);

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        currentViewingOrders: [],
      );
      rethrow;
    }
  }

  Future<void> confirmDeliveredOrder(String orderId) async {
    try {
      state = state.copyWith(isLoading: true);

      await orderRepository.confirmDelivered(orderId);

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        currentViewingOrders: [],
      );
      rethrow;
    }
  }
}
