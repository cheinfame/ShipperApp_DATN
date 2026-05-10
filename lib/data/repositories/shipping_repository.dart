import '../models/account_model.dart';
import '../models/order_model.dart';

abstract class ShippingRepository {
  Future<List<OrderWithInfo>> getCurrentOrders(String shipperId);
  Future<List<OrderWithInfo>> getShippingOrdersByStatus(String shipperId, OrderStatus status);
  Future<Account> updateShipperMaxDistance(
      String shipperId, double maxDistanceAllowance);
  Future<List<OrderWithInfo>> recommendOrdersForShipper(
      String shipperId, double maxDistanceAllowance);
}
