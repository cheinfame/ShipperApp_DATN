import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:packare_shipper/config/path.dart';
import 'package:packare_shipper/config/typography.dart';
import 'package:packare_shipper/data/models/navigating_route_model.dart';
import 'package:packare_shipper/data/models/order_model.dart';
import 'package:packare_shipper/data/models/package_model.dart';
import 'package:packare_shipper/data/models/route_model.dart';
import 'package:packare_shipper/data/repositories/map_repository_impl.dart';
import 'package:packare_shipper/data/repositories/shipping_repository_impl.dart';
import 'package:packare_shipper/data/services/local/shared_preferences_service.dart';
import 'package:packare_shipper/locator.dart';
import 'package:packare_shipper/presentation/home/widgets/location_icon_column.dart';
import 'package:packare_shipper/presentation/navigating/view_model/navigating_state.dart';
import 'package:packare_shipper/presentation/navigating/view_model/navigating_view_model.dart';
import 'package:packare_shipper/presentation/navigating/widget/order_page_view_list.dart';
import 'package:packare_shipper/presentation/orders/view_model/orders_view_model.dart';
import 'package:packare_shipper/utils/foreground_service_handler.dart';
import 'package:url_launcher/url_launcher.dart';

final navigatingViewModelProvider =
    StateNotifierProvider.autoDispose<NavigatingViewModel, NavigatingState>(
  (ref) => NavigatingViewModel(
    ref: ref,
    shippingRepository: locator<ShippingRepositoryImpl>(),
    mapRepository: locator<MapRepositoryImpl>(),
    sharedPreferencesService: locator<SharedPreferencesService>(),
  ),
);

@RoutePage()
class NavigatingScreen extends ConsumerStatefulWidget {
  const NavigatingScreen({Key? key}) : super(key: key);

  @override
  _NavigatingScreenState createState() => _NavigatingScreenState();
}

class _NavigatingScreenState extends ConsumerState<NavigatingScreen> {
  final PageController pickingUpPageController = PageController();
  final PageController deliveringPageController = PageController();

  NavigatingViewModel get viewModel =>
      ref.read(navigatingViewModelProvider.notifier);

  NavigatingState get state => ref.watch(navigatingViewModelProvider);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ForegroundServiceHandler().requestPermission();
      ForegroundServiceHandler().initService();
    });
  }

  @override
  void dispose() {
    pickingUpPageController.dispose();
    deliveringPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WithForegroundTask(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
        floatingActionButton: state.currentNavigatingRoute == null
            ? null
            : _buildFloatingActionButton(),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () => _openGoogleMapsRoute(state.currentNavigatingRoute!),
      child: Image.asset(
        google_map,
        height: 32,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        'Navigating',
        style: AppTypography(context: context).title3,
      ),
    );
  }

  Widget _buildBody() {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state.currentNavigatingRoute != null) {
      return _buildCurrentNavigatingRouteBody();
    }

    return RefreshIndicator(
      onRefresh: () => viewModel.getNavigatingRoutes(),
      child: state.navigatingRoutes.isEmpty
          ? _buildEmptyNavigatingRouteView()
          : _buildNavigatingRoutesList(),
    );
  }

  Widget _buildNavigatingRoutesList() {
    return ListView.separated(
      itemCount: state.navigatingRoutes.length,
      separatorBuilder: (context, index) => const Divider(
        height: 3,
      ),
      itemBuilder: (context, index) {
        return _buildNavigatingRouteListItem(index);
      },
    );
  }

  Widget _buildNavigatingRouteListItem(int index) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      title: Text(
        'Route: ${state.navigatingRoutes[index].route.routeName}',
        style: AppTypography(context: context).title3.copyWith(fontSize: 16),
      ),
      leading: SvgPicture.asset(
        route_logo,
        width: 30,
        height: 30,
      ),
      subtitle: Text(
        'Including ${state.navigatingRoutes[index].ordersFromRoute.length} orders',
        style: AppTypography(context: context).bodyText.copyWith(fontSize: 14),
      ),
      trailing: const Icon(Icons.navigate_next),
      onTap: () async {
        if (state.navigatingRoutes[index].route.routeDirection ==
            RouteDirection.twoWay) {
          await _showDirectionSelector(state.navigatingRoutes[index]);
        } else {
          viewModel.setCurrentNavigatingRouteDirection(
              state.navigatingRoutes[index].route.routeDirection);
        }
        if (state.currentNavigatingRouteDirection != null) {
          viewModel.setCurrentNavigatingRoute(state.navigatingRoutes[index]);
        }
      },
    );
  }

  Widget _buildEmptyNavigatingRouteView() {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                  width: 150,
                  child: SvgPicture.asset(
                    empty_routes,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Freely to take order',
                  style: AppTypography(context: context).title3.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentNavigatingRouteBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRouteInfoColumn(),
            const Divider(
              height: 24,
              thickness: 3,
            ),
            _buildPickingUpSection(),
            const Divider(
              height: 24,
              thickness: 3,
            ),
            _buildOnDeliverySection(),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnDeliverySection() {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(
              packare_logo_path,
              height: 20,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              'On Delivery',
              style: AppTypography(context: context).title3,
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        state.currentDeliveringOrders == null ||
                state.currentDeliveringOrders!.isEmpty
            ? const SizedBox.shrink()
            : OrderPageViewList(
                orderPageController: deliveringPageController,
                orders: state.currentDeliveringOrders!,
                extraActionButtonLabel: 'Confirm Delivered',
                extraActionButtonIcon: Icons.check,
                extraActionButtonCallback: (order) {
                  Future.microtask(
                    () {
                      _showDialog(
                        context,
                        title: 'Confirm Delivered Order',
                        content:
                            'Are you sure you wan\'t to confirm this order?',
                        onConfirm: () => viewModel.confirmDeliveredOrder(order),
                      );
                    },
                  );
                },
              ),
      ],
    );
  }

  Widget _buildPickingUpSection() {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(
              packare_logo_path,
              height: 20,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              'Picking Up',
              style: AppTypography(context: context).title3,
            ),
          ],
        ),
        state.currentPickingUpOrders == null ||
                state.currentPickingUpOrders!.isEmpty
            ? const SizedBox.shrink()
            : OrderPageViewList(
                orderPageController: pickingUpPageController,
                orders: state.currentPickingUpOrders!,
                extraActionButtonLabel: 'Confirm Picked Up',
                extraActionButtonIcon: Icons.check,
                extraActionButtonCallback: (order) {
                  Future.microtask(
                    () {
                      _showDialog(
                        context,
                        title: 'Confirm Picked Up Order',
                        content:
                            'Are you sure you wan\'t to confirm picked up this order?',
                        onConfirm: () => viewModel.confirmPickedUpOrder(order),
                      );
                    },
                  );
                },
              ),
      ],
    );
  }

  Widget _buildRouteInfoColumn() {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(
              route_logo,
              height: 20,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              state.currentNavigatingRoute!.route.routeName ?? 'Unknown Route',
              style: AppTypography(context: context).title3,
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                viewModel.clearCurrentNavigatingRoute();
                viewModel.clearCurrentNavigatingRouteDirection();
              },
              child: Text('Cancel'),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        if (state.currentNavigatingRouteDirection == RouteDirection.startToEnd)
          buildLocationIconColumn(
            context,
            state.currentNavigatingRoute!.route.startLocation,
            state.currentNavigatingRoute!.route.endLocation,
          ),
        if (state.currentNavigatingRouteDirection == RouteDirection.endToStart)
          buildLocationIconColumn(
            context,
            state.currentNavigatingRoute!.route.endLocation,
            state.currentNavigatingRoute!.route.startLocation,
          ),
      ],
    );
  }

  Future<RouteDirection?> _showDirectionSelector(NavigatingRoute route) {
    return showDialog<RouteDirection>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(
          'Select Route Direction',
          style: AppTypography(context: context).title3,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildLocationIconColumn(
              context,
              route.route.startLocation,
              route.route.endLocation,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<RouteDirection>(
              value: state.currentNavigatingRouteDirection,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Direction',
              ),
              items: const [
                DropdownMenuItem(
                  value: RouteDirection.startToEnd,
                  child: Text('Start to End'),
                ),
                DropdownMenuItem(
                  value: RouteDirection.endToStart,
                  child: Text('End to Start'),
                ),
              ],
              onChanged: (value) {
                viewModel.setCurrentNavigatingRouteDirection(value!);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              ref
                  .read(navigatingViewModelProvider.notifier)
                  .clearCurrentNavigatingRouteDirection();
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          Consumer(
            builder: (context, ref, _) {
              return TextButton(
                onPressed: ref
                            .watch(navigatingViewModelProvider)
                            .currentNavigatingRouteDirection ==
                        null
                    ? null
                    : () => Navigator.pop(
                        context, state.currentNavigatingRouteDirection),
                child: const Text('Confirm'),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _openGoogleMapsRoute(NavigatingRoute navigatingRoute) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permission denied';
      }
    }

    // Get current location
    final Position position = await Geolocator.getCurrentPosition();
    final startPoint = [position.longitude, position.latitude];

    final endPoint =
        state.currentNavigatingRouteDirection == RouteDirection.startToEnd
            ? navigatingRoute.route.endCoordinates.coordinates
            : navigatingRoute.route.startCoordinates.coordinates;

    final List<List<double>> waypointsList = [];

    for (int i = 0; i < navigatingRoute.ordersFromRoute.length; i++) {
      final order = navigatingRoute.ordersFromRoute[i];

      if (order.order.status == OrderStatus.startShipping) {
        final pickupPoint = [
          order.order.sendCoordinates.coordinates[0],
          order.order.sendCoordinates.coordinates[1]
        ];
        waypointsList.add(pickupPoint);
      }

      final deliveryPoint = [
        order.order.deliveryCoordinates.coordinates[0],
        order.order.deliveryCoordinates.coordinates[1]
      ];
      waypointsList.add(deliveryPoint);
    }

    // Sort waypoints by latitude, then longitude
    waypointsList.sort((a, b) {
      final latComparison = a[1].compareTo(b[1]); // Compare latitude
      return latComparison != 0
          ? latComparison
          : a[0].compareTo(b[0]); // If latitudes are equal, compare longitude
    });

    // Convert sorted waypoints to lat,lng format for URL
    final sortedWaypoints =
        waypointsList.map((point) => "${point[1]},${point[0]}").join('|');

    final webUrl = Uri.parse('https://www.google.com/maps/dir/?api=1'
        '&origin=${startPoint[1]},${startPoint[0]}' // Fixed starting point
        '&destination=${endPoint[1]},${endPoint[0]}' // Fixed ending point
        '${sortedWaypoints.isNotEmpty ? '&waypoints=$sortedWaypoints' : ''}' // Sorted waypoints
        '&travelmode=driving');

    try {
      await launchUrl(webUrl, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Could not launch navigation: $e');
    }
  }

  void _showDialog(
    BuildContext context, {
    required String title,
    required String content,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
            },
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }
}
