import 'dart:convert';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:geolocator/geolocator.dart';
import 'package:packare_shipper/data/services/api/websocket_service.dart';
import 'package:packare_shipper/data/services/local/shared_preferences_service.dart';
import 'package:packare_shipper/locator.dart';

@pragma('vm:entry-point')
void startLocationSharingTaskCallback() {
  FlutterForegroundTask.setTaskHandler(LocationTaskHandler());
}

class LocationTaskHandler extends TaskHandler {
  late WebSocketService webSocketService;
  String? shipperId;
  List<String>? orderIds; // List to store multiple order IDs

  LocationTaskHandler() {
    webSocketService = WebSocketService();
  }

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    shipperId = await FlutterForegroundTask.getData<String>(key: 'shipperId');
    String? orderIdsString =
        await FlutterForegroundTask.getData<String>(key: 'orderIds');

    if (orderIdsString != null) {
      orderIds = List<String>.from(jsonDecode(orderIdsString));
    }

    if (shipperId != null && orderIds != null && orderIds!.isNotEmpty) {
      webSocketService.initWebSocketService(shipperId!);

      for (var orderId in orderIds!) {
        webSocketService.startLocationStream(orderId, shipperId!);
      }
      print("Started location tracking for orders: $orderIds");
    }
  }

  @override
  void onRepeatEvent(DateTime timestamp) {
    // Send timestamp update to main isolate
    FlutterForegroundTask.sendDataToMain({
      "timestampMillis": timestamp.millisecondsSinceEpoch,
    });
  }

  @override
  Future<void> onDestroy(DateTime timestamp) async {
    if (shipperId != null && orderIds != null && orderIds!.isNotEmpty) {
      for (var orderId in orderIds!) {
        webSocketService.cancelLocationStream(orderId, shipperId!);
      }
      webSocketService.close();
    }
    print("Stopped location tracking for orders: $orderIds");
  }
}
