import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:packare_shipper/.const.dart';
import 'package:packare_shipper/presentation/map/view_model/map_state.dart';
import 'package:packare_shipper/utils/distance_calculator.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:packare_shipper/data/models/order_model.dart';
import 'package:packare_shipper/presentation/map/view_model/map_view_model.dart';
import 'package:packare_shipper/presentation/map/widgets/map_card.dart';
import 'package:packare_shipper/presentation/map/widgets/map_widget.dart';

import '../../../config/typography.dart';

@RoutePage()
class MapScreen extends ConsumerStatefulWidget {
  final OrderWithInfo? orderInfo;
  final bool isNavigating;
  const MapScreen({
    super.key,
    this.orderInfo,
    this.isNavigating = false,
  });

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final MapController _mapController = MapController();
  final String _mapUrlTemplate =
      "https://api.mapbox.com/styles/v1/mapbox/navigation-day-v1/tiles/{z}/{x}/{y}?access_token=$MAPBOX_API_KEY";

  MapState get state => ref.watch(mapViewModelProvider);

  MapViewModel get viewModel => ref.read(mapViewModelProvider.notifier);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.orderInfo != null) {
        viewModel.setRouteGeometry(
          widget.orderInfo!.order.shipperRoute!.geometry,
        );

        viewModel.setWaypoints([
          LatLng(
            widget
                .orderInfo!.order.shipperRoute!.startCoordinates.coordinates[1],
            widget
                .orderInfo!.order.shipperRoute!.startCoordinates.coordinates[0],
          ),
          LatLng(
            widget.orderInfo!.order.shipperRoute!.endCoordinates.coordinates[1],
            widget.orderInfo!.order.shipperRoute!.endCoordinates.coordinates[0],
          ),
        ]);
      }
    });
  }

  @override
  void didUpdateWidget(covariant MapScreen oldWidget) {
    viewModel.updateCenterCoords();

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final hasOrder = widget.orderInfo != null;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: state.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SlidingUpPanel(
                minHeight: hasOrder ? size.height * 0.15 : 0,
                maxHeight: hasOrder ? size.height * 0.25 : 0,
                borderRadius: BorderRadius.circular(12.0),
                color: Theme.of(context).colorScheme.background,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 20.0,
                    color: Colors.grey,
                  ),
                ],
                margin: const EdgeInsets.all(24.0),
                panelBuilder: (sc) => hasOrder
                    ? MapCard(
                        addressList: [
                          widget.orderInfo!.order.shipperRoute!.startLocation,
                          widget.orderInfo!.order.sendAddress,
                          widget.orderInfo!.order.deliveryAddress,
                          widget.orderInfo!.order.shipperRoute!.endLocation
                        ],
                        scrollController: sc,
                      )
                    : const SizedBox.shrink(),
                body: Stack(
                  children: [
                    FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        keepAlive: true,
                        initialCenter: state.centerCoords,
                        initialZoom: state.zoomLevel,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: _mapUrlTemplate,
                          additionalOptions: {
                            'accessToken': MAPBOX_API_KEY,
                            'id': 'mapbox.mapbox-streets-v12',
                          },
                          tileProvider: CancellableNetworkTileProvider(),
                        ),
                        if (state.geometry.isNotEmpty)
                          PolylineLayer(
                            polylines: [
                              Polyline(
                                points: state.geometry
                                    .map((coords) =>
                                        LatLng(coords[0], coords[1]))
                                    .toList(),
                                color: Colors.blue,
                                strokeWidth: 4,
                              ),
                            ],
                          ),
                        _buildMarkerLayer(),
                        _buildCurrentLocationPoint(),
                      ],
                    ),
                    Positioned(
                      bottom: 32,
                      right: 16,
                      child: IconButton(
                        onPressed: () => _mapController.move(
                          state.centerCoords,
                          15.0,
                        ),
                        icon: const Icon(Icons.my_location, color: Colors.blue),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.all(24),
                        ),
                      ),
                    ),
                    hasOrder
                        ? _buildStatusBar(
                            context, widget.orderInfo!.order.status)
                        : const SizedBox.shrink(),
                    Positioned(
                      top: 16,
                      left: 16,
                      child: IconButton(
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildStatusBar(BuildContext context, OrderStatus orderStatus) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(45.0),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 2.0,
                  color: Colors.grey,
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 16,
                ),
                Text(
                  orderStatusMapping(orderStatus),
                  style: AppTypography(context: context).bodyText,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                CircleAvatar(
                  backgroundColor: Colors.blue[600],
                  radius: 4,
                ),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarkerLayer() {
    final markers = <Marker>[
      if (state.startCoords != null)
        Marker(
          width: 40.0,
          height: 40.0,
          point: state.startCoords!,
          child: const Icon(Icons.location_pin, color: Colors.blue),
        ),
      if (state.endCoords != null)
        Marker(
          width: 40.0,
          height: 40.0,
          point: state.endCoords!,
          child: const Icon(Icons.location_pin, color: Colors.red),
        ),
      if (state.waypoints.isNotEmpty)
        ...state.waypoints.asMap().entries.map((entry) {
          final index = entry.key;
          final waypoint = entry.value;
          return Marker(
            width: 40.0,
            height: 40.0,
            point: waypoint,
            child: Icon(
              Icons.location_pin,
              color: index == 0 ? Colors.yellow : Colors.green,
            ),
          );
        }),
    ];
    return MarkerLayer(markers: markers);
  }

  Widget _buildCurrentLocationPoint() {
    return StreamBuilder<Position>(
      stream: Geolocator.getPositionStream(),
      builder: (context, positionSnapshot) {
        if (!positionSnapshot.hasData) {
          return const SizedBox.shrink();
        }
        final position = positionSnapshot.data!;
        return CircleLayer(
          circles: [
            CircleMarker(
              point: LatLng(
                position.latitude,
                position.longitude,
              ),
              radius: 12,
              color: Colors.blue.withOpacity(0.2),
              borderStrokeWidth: 2,
              borderColor: Colors.blue.withOpacity(0.4),
            ),
            CircleMarker(
              point: LatLng(
                position.latitude,
                position.longitude,
              ),
              radius: 8,
              color: Colors.blue.withOpacity(0.8),
              borderStrokeWidth: 2,
              borderColor: Colors.blue,
            ),
          ],
        );
      },
    );
  }
}
