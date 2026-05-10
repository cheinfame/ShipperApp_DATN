import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:packare_shipper/data/models/account_model.dart';
import 'package:packare_shipper/data/models/order_model.dart';
import 'package:packare_shipper/data/repositories/order_repository_impl.dart';
import 'package:packare_shipper/data/repositories/shipping_repository_impl.dart';
import 'package:packare_shipper/data/repositories/user_repository_impl.dart';
import 'package:packare_shipper/data/services/api/websocket_service.dart';
import 'package:packare_shipper/locator.dart';
import 'package:packare_shipper/presentation/routes/view_model/routes_view_model.dart';
import 'package:packare_shipper/shared/account_view_model/account_view_model.dart';
import 'package:packare_shipper/presentation/home/view_models/home_view_model/home_state.dart';
import 'package:packare_shipper/presentation/home/view_models/home_view_model/home_view_model.dart';
import 'package:packare_shipper/router/app_router.dart';

import '../../config/path.dart';
import 'widgets/user_dashboard.dart';

import '../orders/screens/order_detail_screen.dart';
import '../../config/typography.dart';

import 'widgets/shipper_home_order_list_item.dart';

// quản lý lại dơn hàng theo tuyến đường, tạo màn hình mới có danh sách tuyến đường
// ở tuyến đường cụ thể sẽ có điều hướng cho các đơn hàng bên trong tuyến đường đó

final _homeViewModelProvider =
    StateNotifierProvider<HomeViewModel, HomeState>((ref) => HomeViewModel(
          ref: ref,
          orderRepository: locator<OrderRepositoryImpl>(),
          shippingRepository: locator<ShippingRepositoryImpl>(),
          userRepository: locator<UserRepositoryImpl>(),
        ));

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  HomeState get homeState => ref.watch(_homeViewModelProvider);

  Account? get shipperAccount => ref.watch(accountViewModelProvider);

  @override
  Widget build(BuildContext context) {
    if (shipperAccount == null) {
      _showAccountFetchingFailedDialog(context);
    }

    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserDashboard(account: shipperAccount),
        const SizedBox(
          height: 16,
        ),
        _buildAvailableOrdersTitle(),
        const SizedBox(
          height: 16,
        ),
        _buildAvailableOrdersListViewSection(),
      ],
    );
  }

  Widget _buildAvailableOrdersListViewSection() {
    // Initialize routeState early so we can get routes name without delay
    final routesState = ref.watch(routesViewModelProvider(shipperAccount!));

    return Expanded(
      child: homeState.isLoading || routesState.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () => ref
                  .read(_homeViewModelProvider.notifier)
                  .refreshRecommendedOrders(),
              child: homeState.availableOrders.isEmpty
                  ? _buildEmptyAvailableOrderView()
                  : _buildAvailableOrdersListView(),
            ),
    );
  }

  Widget _buildAvailableOrdersListView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: homeState.availableOrders.length,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 12.0);
        },
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () => context.router.push(
              OrderDetailRoute(order: homeState.availableOrders[index].order),
            ),
            child: ShipperHomeOrderListItem(
              orderInfo: homeState.availableOrders[index],
              compatibleRouteName: homeState.routeNamesMap[
                      homeState.availableOrders[index].shipperRouteId] ??
                  'Unknown Route',
              onAcceptOrderTapped: () =>
                  onAcceptOrderTapped(homeState.availableOrders[index]),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyAvailableOrderView() {
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
                    packare_logo_path,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'No Order Available',
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

  Widget _buildAvailableOrdersTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Text(
        'Available Orders',
        style: AppTypography(context: context).bodyText.copyWith(
              color: Colors.grey[600],
              fontWeight: FontWeight.w600,
              fontSize: 14.0,
            ),
      ),
    );
  }

  Future<void> onAcceptOrderTapped(OrderWithInfo order) async {
    try {
      await ref
          .read(_homeViewModelProvider.notifier)
          .acceptOrder(order, shipperAccount!.shipper!.shipperId);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Order accepted successfully'),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to accept order: ${e.toString()}'),
          ),
        );
      }
    }
  }

  Future<void> _showAccountFetchingFailedDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content:
              const Text('Failed getting Account\'s data\n Please login again'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();

                // Navigate after the dialog is closed
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.router.replaceAll([AuthenticationRoute()]);
                });
              },
            ),
          ],
        );
      },
    );
  }
}
