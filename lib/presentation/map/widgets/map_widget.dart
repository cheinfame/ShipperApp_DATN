import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../../../config/typography.dart';
import '../../../.const.dart';
import '../../../utils/distance_calculator.dart';

class MapWidget extends StatefulWidget {
  final List<LatLng>? waypoints;
  final List<List<double>>? geometry;
  final LatLng? startCoords;
  final LatLng? endCoords;
  final bool isCreatingRoute;

  const MapWidget({
    Key? key,
    this.waypoints,
    this.geometry,
    this.startCoords,
    this.endCoords,
    this.isCreatingRoute = false,
  }) : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final MapController _mapController = MapController();
  final String _mapUrlTemplate =
      "https://api.mapbox.com/styles/v1/mapbox/navigation-day-v1/tiles/{z}/{x}/{y}?access_token=$MAPBOX_API_KEY";

  Position? _currentPosition;
  LatLng? _centerCoords;
  double _initialZoom = 13.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _centerMapToCoords();
    });
  }

  @override
  void didUpdateWidget(MapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _centerMapToCoords();
  }

  void _centerMapToCoords() {
    final startCoords = widget.startCoords;
    final endCoords = widget.endCoords;

    if (startCoords == null && endCoords == null) return;

    if (startCoords != null && endCoords != null) {
      final distance = calculateDistance(startCoords, endCoords);
      _initialZoom = _calculateZoomLevel(distance);
      _centerCoords = LatLng(
        (startCoords.latitude + endCoords.latitude) / 2,
        (startCoords.longitude + endCoords.longitude) / 2,
      );
    } else {
      _centerCoords = startCoords ?? endCoords!;
    }
    setState(() {});

    _mapController.move(_centerCoords!, _initialZoom);
  }

  double _calculateZoomLevel(double distance) {
    if (distance < 100) return 18.0;
    if (distance < 200) return 17.0;
    if (distance < 500) return 16.0;
    if (distance < 1000) return 15.5;
    if (distance < 2000) return 14.5;
    if (distance < 5000) return 13.5;
    if (distance < 10000) return 12.5;
    if (distance < 20000) return 11.5;
    return 10.0;
  }

  Widget _buildMarkerLayer() {
    final markers = <Marker>[
      if (widget.startCoords != null)
        Marker(
          width: 40.0,
          height: 40.0,
          point: widget.startCoords!,
          child: const Icon(Icons.location_pin, color: Colors.blue),
        ),
      if (widget.endCoords != null)
        Marker(
          width: 40.0,
          height: 40.0,
          point: widget.endCoords!,
          child: const Icon(Icons.location_pin, color: Colors.red),
        ),
      if (widget.waypoints != null)
        ...widget.waypoints!.asMap().entries.map((entry) {
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            keepAlive: true,
            initialCenter: _centerCoords ??
                LatLng(
                  _currentPosition?.latitude ?? 0,
                  _currentPosition?.longitude ?? 0,
                ),
            initialZoom: _initialZoom,
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
            if (widget.geometry != null && widget.geometry!.isNotEmpty)
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: widget.geometry!
                        .map((coords) => LatLng(coords[0], coords[1]))
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
      ],
    );
  }
}
