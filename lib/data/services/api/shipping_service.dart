import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:packare_shipper/data/models/order_model.dart';
import '../../../.const.dart';

class ShippingService {
  Future<Map<String, dynamic>> _handleResponse(http.Response response) async {
    final Map<String, dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return data;
    } else {
      throw Exception(
          'Request failed with status: ${response.statusCode}. Response: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> updateShipperMaxDistance(
      String token, String shipperId, double maxDistanceAllowance) async {
    final url = Uri.parse('$baseUri/shipper/max-distance/$shipperId');
    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'max_distance_allowance': maxDistanceAllowance,
      }),
    );

    return await _handleResponse(response);
  }

  Future<Map<String, dynamic>> recommendOrdersForShipper(
      String token, String shipperId, double maxDistanceAllowance) async {
    final url = Uri.parse('$baseUri/shipper/recommend-orders');
    final requestBody = jsonEncode({
      'shipper_id': shipperId,
      'max_distance_allowance': maxDistanceAllowance.toString(),
    });

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: requestBody,
    );

    return await _handleResponse(response);
  }

  Future<Map<String, dynamic>> getCurrentOrders(
      String token, String shipperId) async {
    final url = Uri.parse('$baseUri/shipper/current-orders/$shipperId');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    return await _handleResponse(response);
  }

  Future<Map<String, dynamic>> getShippingOrdersByStatus(
      String token, String shipperId, OrderStatus status) async {
    final url = Uri.parse(
        '$baseUri/shipper/shipping-orders/$shipperId/${Order.orderStatusToJson(status)}');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    return await _handleResponse(response);
  }
}
