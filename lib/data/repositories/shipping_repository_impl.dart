import 'dart:io';
import 'package:flutter/services.dart';
import 'package:packare_shipper/data/models/route_model.dart';
import 'package:packare_shipper/data/repositories/map_repository_impl.dart';
import 'package:packare_shipper/data/repositories/user_repository_impl.dart';
import '../models/account_model.dart';
import '../models/order_model.dart';
import 'shipping_repository.dart';
import '../services/local/secure_storage_service.dart';
import '../services/api/shipping_service.dart';

class ShippingRepositoryImpl implements ShippingRepository {
  final ShippingService _shipperService;
  final SecureStorageService _secureStorage;
  final UserRepositoryImpl _userRepository;
  final MapRepositoryImpl _mapRepository;

  ShippingRepositoryImpl({
    required ShippingService shipperService,
    required SecureStorageService secureStorageService,
    required UserRepositoryImpl userRepository,
    required MapRepositoryImpl mapRepository,
  })  : _shipperService = shipperService,
        _secureStorage = secureStorageService,
        _userRepository = userRepository,
        _mapRepository = mapRepository;

  Future<String?> _getToken() async {
    final token = await _secureStorage.getStringValue('token');
    if (token == null) {
      throw Exception('Token not found');
    }
    return token;
  }

  @override
  Future<List<OrderWithInfo>> getCurrentOrders(String shipperId) async {
    try {
      final token = await _getToken();

      final response =
          await _shipperService.getCurrentOrders(token!, shipperId);

      // Parse JSON response
      final List<dynamic> jsonOrders =
          response['currentOrders']; // Ensure it's a list

      // Map JSON orders to OrderWithInfo objects
      final List<OrderWithInfo> ordersWithInfo = [];
      for (var jsonOrder in jsonOrders) {
        // Parse JSON order data
        Order order = Order.fromJson(jsonOrder);
        final distance = double.parse(jsonOrder['distance'].toString());
        final List<List<double>> orderGeometry =
            (jsonOrder['order_geometry'] as List<dynamic>)
                .map<List<double>>((dynamic e) => (e as List<dynamic>)
                    .map<double>((dynamic e) => e.toDouble())
                    .toList())
                .toList();
        final shipperRouteId = jsonOrder['shipper_route_id'];

        if(order.status != OrderStatus.completed && order.status != OrderStatus.cancelled) {
          final Account sender =
              await _userRepository.getUserProfile(order.senderId);

          final Route shipperRoute =
              await _mapRepository.getRouteById(shipperRouteId);

          order = order.copyWith(sender: sender, shipperRoute: shipperRoute);
        }
        // Create OrderWithInfo object
        final orderWithInfo = OrderWithInfo(
          order: order,
          distance: distance,
          orderGeometry: orderGeometry,
          shipperRouteId: shipperRouteId,
        );

        // Add order to the list
        ordersWithInfo.add(orderWithInfo);
      }

      return ordersWithInfo;
    } on SocketException catch (_) {
      throw PlatformException(
          code: 'NETWORK_ERROR', message: 'Network error occurred.');
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<OrderWithInfo>> getShippingOrdersByStatus(
      String shipperId, OrderStatus status) async {
    try {
      final token = await _getToken();

      final response = await _shipperService.getShippingOrdersByStatus(
          token!, shipperId, status);

      // Parse JSON response
      final List<dynamic> jsonOrders =
          response['orders']; // Ensure it's a list;

      // Map JSON orders to OrderWithInfo objects
      final List<OrderWithInfo> ordersWithInfo = [];
      for (var jsonOrder in jsonOrders) {
        // Parse JSON order data
        Order order = Order.fromJson(jsonOrder);
        final distance = double.parse(jsonOrder['distance'].toString());
        final List<List<double>> orderGeometry =
            (jsonOrder['order_geometry'] as List<dynamic>)
                .map<List<double>>((dynamic e) => (e as List<dynamic>)
                    .map<double>((dynamic e) => e.toDouble())
                    .toList())
                .toList();
        final shipperRouteId = jsonOrder['shipper_route_id'];

        if(order.status != OrderStatus.completed && order.status != OrderStatus.cancelled) {
          final Account sender =
              await _userRepository.getUserProfile(order.senderId);

          final Route shipperRoute =
              await _mapRepository.getRouteById(shipperRouteId);

          order = order.copyWith(sender: sender, shipperRoute: shipperRoute);
        }

        // Create OrderWithInfo object
        final orderWithInfo = OrderWithInfo(
          order: order,
          distance: distance,
          orderGeometry: orderGeometry,
          shipperRouteId: shipperRouteId,
        );

        // Add order to the list
        ordersWithInfo.add(orderWithInfo);
      }

      return ordersWithInfo;
    } on SocketException catch (_) {
      throw PlatformException(
          code: 'NETWORK_ERROR', message: 'Network error occurred.');
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Account> updateShipperMaxDistance(
      String shipperId, double maxDistanceAllowance) async {
    try {
      final token = await _getToken();

      final response = await _shipperService.updateShipperMaxDistance(
          token!, shipperId, maxDistanceAllowance);

      return Account.fromJson(response['shipper']);
    } on SocketException catch (_) {
      throw PlatformException(
          code: 'NETWORK_ERROR', message: 'Network error occurred.');
    } catch (error) {
      print('Error updating shipper max distance: $error');
      rethrow;
    }
  }

  @override
  Future<List<OrderWithInfo>> recommendOrdersForShipper(
      String shipperId, double maxDistanceAllowance) async {
    try {
      final token = await _getToken();

      final response = await _shipperService.recommendOrdersForShipper(
          token!, shipperId, maxDistanceAllowance);

      final List<OrderWithInfo> orderWithInfo = [];
      // Check if response contains the key 'recommendedOrders'
      if (response.containsKey('recommendedOrders')) {
        final List<dynamic> orderData = response['recommendedOrders'];
        for (var orderJson in orderData) {
          final Order order = Order.fromJson(orderJson['order']);
          final double distance =
              double.parse(orderJson['distance'].toString());
          final List<List<double>> orderGeometry = List<List<double>>.from(
              orderJson['orderGeometry'].map((item) => List<double>.from(
                  item.map((subItem) => subItem.toDouble()))));
          final String routeId = orderJson['orderRouteId'];

          orderWithInfo.add(OrderWithInfo(
              order: order,
              distance: distance,
              orderGeometry: orderGeometry,
              shipperRouteId: routeId));
        }
      } else {
        throw Exception('Invalid response format');
      }

      return orderWithInfo;
    } on SocketException catch (_) {
      throw PlatformException(
          code: 'NETWORK_ERROR', message: 'Network error occurred.');
    } catch (error) {
      print('Error recommending orders for shipper: $error');
      rethrow;
    }
  }
}
