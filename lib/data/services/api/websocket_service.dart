import 'dart:async';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

import '../../../.const.dart';

class WebSocketService {
  static final WebSocketService _instance = WebSocketService._internal();
  factory WebSocketService() => _instance;
  WebSocketService._internal();

  final Map<String, StreamSubscription<Position>> _locationStreams = {};
  late WebSocketChannel _channel;
  late Timer _heartbeatTimer = Timer(Duration.zero, () {}); 
  static const int _heartbeatTimeout = 15000; // 15 seconds

  void initWebSocketService(String userId) {
    _channel = IOWebSocketChannel.connect(wsUri);
    _channel.stream.listen(_handleMessage);

    sendUserId(userId);
    _startHeartbeatTimer();
  }

  void _startHeartbeatTimer() {
    _heartbeatTimer =
        Timer.periodic(Duration(milliseconds: _heartbeatTimeout), (timer) {
      print('Heartbeat timeout: No ping received from server.');
    });
  }

  void sendUserId(String userId) {
    _channel.sink.add(jsonEncode({'type': 'user-id', 'userId': userId}));
  }

  void _resetHeartbeatTimer() {
    _heartbeatTimer.cancel();
    _startHeartbeatTimer();
  }

  void _handleMessage(dynamic message) {
    _resetHeartbeatTimer();
    Map<String, dynamic> parsedMessage = jsonDecode(message);
    
    if (parsedMessage['type'] == 'ping') {
      _channel.sink.add(jsonEncode({'type': 'pong'}));
      return;
    }

    switch (parsedMessage['type']) {
      case 'order-status-notification':
        // Handle order status notification
        break;
      case 'shipper-location-update':
        // Handle shipper location update
        break;
      default:
        print('Unknown message type: ${parsedMessage['type']}');
    }
  }

  void subscribeToShipperLocation(String orderId) {
    _channel.sink.add(jsonEncode({'type': 'subscribe-shipper-location', 'orderId': orderId}));
  }

  void _sendShipperLocation(String orderId, String shipperId, double latitude, double longitude) {
    _channel.sink.add(jsonEncode({
      'type': 'shipper-location-update',
      'orderId': orderId,
      'shipperId': shipperId,
      'latitude': latitude,
      'longitude': longitude,
    }));
  }

  void startLocationStream(String orderId, String shipperId) {
    if (_locationStreams.containsKey(orderId)) {
      print("Location stream for order $orderId already running.");
      return;
    }

    var subscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    ).listen((Position position) {
      _sendShipperLocation(orderId, shipperId, position.latitude, position.longitude);
      print("Sending location for order $orderId.");
    });

    _locationStreams[orderId] = subscription;
  }

  void cancelLocationStream(String orderId, String shipperId) {
    if (_locationStreams.containsKey(orderId)) {
      _locationStreams[orderId]!.cancel();
      _locationStreams.remove(orderId);
      print("Location stream for order $orderId stopped.");
      _channel.sink.add(jsonEncode({'type': 'cancel-location-sharing', 'orderId': orderId, 'shipperId': shipperId}));
    }
  }

  void close() {
    _heartbeatTimer.cancel();
    _channel.sink.close();
  }
}
