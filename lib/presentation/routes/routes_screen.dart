import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:packare_shipper/data/models/account_model.dart';
import 'package:packare_shipper/data/models/route_model.dart' as route_model;
import 'package:packare_shipper/presentation/routes/view_model/routes_state.dart';
import 'package:packare_shipper/presentation/routes/view_model/routes_view_model.dart';
import 'package:packare_shipper/router/app_router.dart';
import 'package:packare_shipper/shared/account_view_model/account_view_model.dart';
import '../../config/path.dart';
import '../../config/typography.dart';
import 'widgets/save_route_sheet.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../create_route/create_route_screen.dart';

@RoutePage()
class RoutesScreen extends ConsumerStatefulWidget {
  const RoutesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RoutesScreen> createState() => _RoutesScreenState();
}

class _RoutesScreenState extends ConsumerState<RoutesScreen> {
  TextEditingController _updateRouteNameController=TextEditingController();
  TextEditingController _updateStartLocationController=TextEditingController();
  TextEditingController _updateEndLocationController=TextEditingController();
  late Account? shipperAccount;

  RoutesState get state => ref.watch(routesViewModelProvider(shipperAccount!));

  RoutesViewModel get viewModel =>
      ref.read(routesViewModelProvider(shipperAccount!).notifier);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    shipperAccount = ref.read(accountViewModelProvider);

    if (shipperAccount == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showErrorDialog(
          context: context,
          title: 'Error',
          content:
              'Unable to retrieve shipper account information. Please log in again.',
          buttonText: 'Go to Login',
          onButtonPressed: () {
            context.router.replaceAll([AuthenticationRoute()]);
          },
        );
      });
    }
  }

  @override
  void dispose() {
    _updateRouteNameController.dispose();
    _updateStartLocationController.dispose();
    _updateEndLocationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        'Routes',
        style: AppTypography(context: context).title3,
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          tooltip: 'Create Route',
          onPressed: () {
            // Navigate to create route screen
            context.pushRoute(CreateRouteRoute());
          },
        ),
      ],
    );
  }

  Widget _buildBody() {
    return state.isLoading
        ? const Center(child: CircularProgressIndicator())
        : state.routes.isEmpty
            ? _buildEmptyRouteView()
            : _buildRoutesListView();
  }

  Widget _buildRoutesListView() {
    return RefreshIndicator(
      onRefresh: () async {
        viewModel.getRoutes();
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: state.routes.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final route = state.routes[index];
            bool isActive = route.isActive;

            return _buildRouteItem(route, isActive);
          },
        ),
      ),
    );
  }

  Widget _buildRouteItem(route_model.Route route, bool isActive) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            flex: 1,
            onPressed: (context) {
              viewModel.deleteRoute(route.routeId!);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          route.routeName!,
          style: AppTypography(context: context).heading1,
        ),
        leading: SvgPicture.asset(
          route_logo,
          width: 30,
          height: 30,
        ),
        subtitle: Text(
          'Distance: ${(route.distance / 1000).toStringAsFixed(2)} km \nDuration: ${(route.duration / 60).toStringAsFixed(2)} mins',
          style: AppTypography(context: context).bodyText.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
              ),
        ),
        trailing: Switch(
          value: isActive,
          onChanged: (bool value) async {
            await _onRouteActiveStatusUpdate(route, value);
          },
        ),
        onTap: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            _updateRouteNameController =
                TextEditingController(text: route.routeName);
            _updateEndLocationController =
                TextEditingController(text: route.endLocation);
            _updateStartLocationController =
                TextEditingController(text: route.startLocation);
            return SaveRouteSheet(
              isUpdatingRouteProcess: true,
              routeNameController: _updateRouteNameController,
              startLocationController: _updateStartLocationController,
              endLocationController: _updateEndLocationController,
              routeInfo: route,
              onSaveButtonTapped: (route_model.Route updatedRoute) =>
                  _onSaveButtonPressed(updatedRoute),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyRouteView() {
    return RefreshIndicator(
      onRefresh: () async {
        viewModel.getRoutes();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: SvgPicture.asset(
                    empty_routes,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'No Route Available',
                style: AppTypography(context: context).title3.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onSaveButtonPressed(route_model.Route updatedRoute) async {
    try {
      await viewModel.updateRoute(updatedRoute);

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Information updated successfully'),
          duration: Duration(seconds: 1),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Information updated successfully'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  void showErrorDialog({
    required BuildContext context,
    required String title,
    required String content,
    required String buttonText,
    required VoidCallback onButtonPressed,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: onButtonPressed,
              child: Text(buttonText),
            ),
          ],
        );
      },
    );
  }

  Future<void> _onRouteActiveStatusUpdate(
      route_model.Route currentRoute, bool updateValue) async {
    try {
      await viewModel.updateRoute(currentRoute.copyWith(isActive: updateValue));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '${currentRoute.routeName} is ${updateValue ? 'on' : 'off'}'),
          duration: const Duration(seconds: 1),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Failed to change ${currentRoute.routeName} active status: $e'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }
}
