import 'dart:io';
import 'package:flutter/services.dart';
import '../models/order_feedback_model.dart';

import '../models/order_model.dart';
import '../models/package_model.dart';
import '../repositories/order_repository.dart';
import '../services/local/secure_storage_service.dart';
import '../services/api/order_service.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderService _orderService;
  final SecureStorageService _secureStorage;

  OrderRepositoryImpl({
    required OrderService orderApiService,
    required SecureStorageService secureStorageService,
  })  : _orderService = orderApiService,
        _secureStorage = secureStorageService;

  @override
  Future<Order> createOrder(Order order) async {
    try {
      final token = await _secureStorage.getStringValue('token');
      if (token == null) {
        throw Exception('Token not found');
      }

      final response = await _orderService.createOrder(token, order);
      final createdOrder = Order.fromJson(response['order']);

      return createdOrder;
    } catch (error) {
      if (error is SocketException) {
        throw PlatformException(
            code: 'NETWORK_ERROR', message: 'Network error occurred.');
      }
      rethrow;
    }
  }

  @override
  Future<Order> getOrderById(String orderId) async {
    try {
      final token = await _secureStorage.getStringValue('token');
      if (token == null) {
        throw Exception('Token not found');
      }

      final response = await _orderService.getOrderById(token, orderId);
      return Order.fromJson(response['order']);
    } catch (error) {
      if (error is SocketException) {
        throw PlatformException(
            code: 'NETWORK_ERROR', message: 'Network error occurred.');
      }
      rethrow;
    }
  }

  @override
  Future<List<Order>> getOrdersByUser(String userId) async {
    try {
      final token = await _secureStorage.getStringValue('token');
      if (token == null) {
        throw Exception('Token not found');
      }

      final response = await _orderService.getOrdersByUser(token, userId);

      List<Order> orders = [];

      for (var order in response['orders']) {
        orders.add(Order.fromJson(order));
      }

      return orders;
    } catch (error) {
      if (error is SocketException) {
        throw PlatformException(
            code: 'NETWORK_ERROR', message: 'Network error occurred.');
      }
      rethrow;
    }
  }

  @override
  Future<List<Order>> getOrdersByStatus(
      String userId, OrderStatus status) async {
    try {
      final token = await _secureStorage.getStringValue('token');
      if (token == null) {
        throw Exception('Token not found');
      }

      final response = await _orderService.getOrdersByStatus(
          token, userId, orderStatusMapping(status));

      List<Order> orders = [];

      for (var order in response['orders']) {
        orders.add(Order.fromJson(order));
      }

      return orders;
    } catch (error) {
      if (error is SocketException) {
        throw PlatformException(
            code: 'NETWORK_ERROR', message: 'Network error occurred.');
      }
      rethrow;
    }
  }

  @override
  Future<void> orderFeedback(String orderId, OrderFeedback feedback) async {
    try {
      final token = await _secureStorage.getStringValue('token');
      if (token == null) {
        throw Exception('Token not found');
      }

      await _orderService.orderFeedback(token, orderId, feedback);
    } catch (error) {
      if (error is SocketException) {
        throw PlatformException(
            code: 'NETWORK_ERROR', message: 'Network error occurred.');
      }
      rethrow;
    }
  }

  @override
  Future<void> acceptOrder(
      String orderId,
      String shipperId,
      String shipperRouteId,
      List<List<double>> orderGeometry,
      double distance) async {
    try {
      final token = await _secureStorage.getStringValue('token');
      if (token == null) {
        throw Exception('Token not found');
      }

      await _orderService.acceptOrder(
          token, orderId, shipperId, shipperRouteId, orderGeometry, distance);
    } catch (error) {
      if (error is SocketException) {
        throw PlatformException(
            code: 'NETWORK_ERROR', message: 'Network error occurred.');
      }
      rethrow;
    }
  }

  @override
  Future<void> verifyOrder(String orderId) async {
    try {
      final token = await _secureStorage.getStringValue('token');
      if (token == null) {
        throw Exception('Token not found');
      }

      await _orderService.verifyOrder(token, orderId);
    } catch (error) {
      if (error is SocketException) {
        throw PlatformException(
            code: 'NETWORK_ERROR', message: 'Network error occurred.');
      }
      rethrow;
    }
  }

  @override
  Future<void> declineOrder(String orderId) async {
    try {
      final token = await _secureStorage.getStringValue('token');
      if (token == null) {
        throw Exception('Token not found');
      }

      await _orderService.declineOrder(token, orderId);
    } catch (error) {
      if (error is SocketException) {
        throw PlatformException(
            code: 'NETWORK_ERROR', message: 'Network error occurred.');
      }
      rethrow;
    }
  }

  @override
  Future<void> confirmPickup(String orderId) async {
    try {
      final token = await _secureStorage.getStringValue('token');
      if (token == null) {
        throw Exception('Token not found');
      }

      await _orderService.confirmPickup(token, orderId);
    } catch (error) {
      if (error is SocketException) {
        throw PlatformException(
            code: 'NETWORK_ERROR', message: 'Network error occurred.');
      }
      rethrow;
    }
  }

  @override
  Future<void> confirmDelivered(String orderId) async {
    try {
      final token = await _secureStorage.getStringValue('token');
      if (token == null) {
        throw Exception('Token not found');
      }

      await _orderService.confirmDelivered(token, orderId);
    } catch (error) {
      if (error is SocketException) {
        throw PlatformException(
            code: 'NETWORK_ERROR', message: 'Network error occurred.');
      }
      rethrow;
    }
  }

  @override
  Future<void> completeOrder(String orderId) async {
    try {
      final token = await _secureStorage.getStringValue('token');
      if (token == null) {
        throw Exception('Token not found');
      }

      await _orderService.completeOrder(token, orderId);
    } catch (error) {
      if (error is SocketException) {
        throw PlatformException(
            code: 'NETWORK_ERROR', message: 'Network error occurred.');
      }
      rethrow;
    }
  }

  @override
  Future<void> cancelOrder(String orderId) async {
    try {
      final token = await _secureStorage.getStringValue('token');
      if (token == null) {
        throw Exception('Token not found');
      }

      await _orderService.cancelOrder(token, orderId);
    } catch (error) {
      if (error is SocketException) {
        throw PlatformException(
            code: 'NETWORK_ERROR', message: 'Network error occurred.');
      }
      rethrow;
    }
  }

  @override
  Future<void> startShipping(String orderId) async {
    try {
      final token = await _secureStorage.getStringValue('token');
      if (token == null) {
        throw Exception('Token not found');
      }

      await _orderService.startShipping(token, orderId);
    } catch (error) {
      if (error is SocketException) {
        throw PlatformException(
          code: 'NETWORK_ERROR',
          message: 'Network error occurred.',
        );
      }
      rethrow;
    }
  }

  @override
  Future<List<Order>> viewOrderHistory() async {
    try {
      final token = await _secureStorage.getStringValue('token');
      if (token == null) {
        throw Exception('Token not found');
      }

      final response = await _orderService.viewOrderHistory(token);
      final List<Order> orderHistory = List<Order>.from(
        response['orders'].map((order) => Order.fromJson(order)),
      );

      return orderHistory;
    } catch (error) {
      if (error is SocketException) {
        throw PlatformException(
          code: 'NETWORK_ERROR',
          message: 'Network error occurred.',
        );
      }
      rethrow;
    }
  }

  @override
  Future<List<Package>> getOrderPackages(String orderId) async {
    try {
      final token = await _secureStorage.getStringValue('token');
      if (token == null) {
        throw Exception('Token not found');
      }

      final response = await _orderService.getOrderPackages(token, orderId);

      final List<Package> packages = List<Package>.from(
        response['packages'].map((package) => Package.fromJson(package)),
      );

      return packages;
    } catch (error) {
      if (error is SocketException) {
        throw PlatformException(
          code: 'NETWORK_ERROR',
          message: 'Network error occurred.',
        );
      }
      rethrow;
    }
  }

  @override
  Future<void> updatePackage(
      String orderId, String packageId, Package package) async {
    try {
      final token = await _secureStorage.getStringValue('token');
      if (token == null) {
        throw Exception('Token not found');
      }
      await _orderService.updatePackage(token, orderId, packageId, package);
    } catch (error) {
      if (error is SocketException) {
        throw PlatformException(
          code: 'NETWORK_ERROR',
          message: 'Network error occurred.',
        );
      }
      rethrow;
    }
  }

  @override
  Future<void> deletePackage(String orderId, String packageId) async {
    try {
      final token = await _secureStorage.getStringValue('token');
      if (token == null) {
        throw Exception('Token not found');
      }

      await _orderService.deletePackage(token, orderId, packageId);
    } catch (error) {
      if (error is SocketException) {
        throw PlatformException(
          code: 'NETWORK_ERROR',
          message: 'Network error occurred.',
        );
      }
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> calculateShippingPrice(
      Map<String, dynamic> coordinates) async {
    try {
      final token = await _secureStorage.getStringValue('token');
      if (token == null) {
        throw Exception('Token not found');
      }

      final response =
          await _orderService.calculateShippingPrice(token, coordinates);

      final double shippingPrice =
          (response['shippingPrice'] as num).toDouble();
      final double distance = double.parse(
          ((response['distance'] as num).toDouble()).toStringAsFixed(2));

      // Return the extracted data
      return {
        'distance': distance,
        'shippingPrice': shippingPrice,
      };
    } catch (error) {
      if (error is SocketException) {
        throw PlatformException(
          code: 'NETWORK_ERROR',
          message: 'Network error occurred.',
        );
      }
      rethrow;
    }
  }
}
