import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:packare_shipper/data/repositories/order_repository_impl.dart';
import 'package:packare_shipper/data/repositories/shipping_repository_impl.dart';
import 'package:packare_shipper/locator.dart';
import 'package:packare_shipper/presentation/orders/view_model/orders_state.dart';
import 'package:packare_shipper/presentation/orders/view_model/orders_view_model.dart';

import '../../../config/typography.dart';
import '../../../data/models/order_model.dart';
import '../widgets/orders_list_item.dart';
import '../../../config/path.dart';

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  ConsumerState<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final List<Text> _tabLabels = const [
    Text("Available Order"),
    Text("Picking Up Order"),
    Text("On Delivery"),
    Text("Delivery Successful"),
    Text("Completed")
  ];

  OrderStatus _getOrderStatusForTabIndex(int index) {
    switch (index) {
      case 0:
        return OrderStatus.shipperAccepted;
      case 1:
        return OrderStatus.startShipping;
      case 2:
        return OrderStatus.shipperPickedUp;
      case 3:
        return OrderStatus.delivered;
      case 4:
        return OrderStatus.completed;
      default:
        return OrderStatus.shipperAccepted;
    }
  }

  OrdersViewModel get viewModel => ref.read(ordersViewModelProvider.notifier);

  OrdersState get state => ref.watch(ordersViewModelProvider);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabLabels.length, vsync: this)
      ..addListener(() {
        // When change tab, fetch orders based on OrderStatus
        viewModel.setCurrentViewingOrdersType(
            _getOrderStatusForTabIndex(_tabController.index));

        viewModel.fetchOrders();
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
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
    final tabLabelTextStyle = AppTypography(context: context)
        .footnote
        .copyWith(fontWeight: FontWeight.normal);
    final colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      title: Text(
        "Orders",
        style: AppTypography(context: context).title3,
      ),
      bottom: TabBar(
        controller: _tabController,
        isScrollable: true,
        labelPadding: const EdgeInsets.all(16.0),
        unselectedLabelStyle: tabLabelTextStyle,
        labelStyle: tabLabelTextStyle,
        labelColor: colorScheme.primary,
        tabs: _tabLabels,
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Expanded(
          child: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: () async {
                    await viewModel.fetchOrders();
                  },
                  child: TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildOrderTab(
                        context: context,
                        status: OrderStatus.shipperAccepted,
                        haveCancelButton: true,
                        extraActionButtonLabel: 'Start Shipping',
                        extraActionButtonIcon: Icons.check,
                      ),
                      _buildOrderTab(
                        context: context,
                        status: OrderStatus.startShipping,
                        extraActionButtonLabel: 'Confirm Picked Up',
                        extraActionButtonIcon: Icons.check,
                      ),
                      _buildOrderTab(
                        context: context,
                        status: OrderStatus.shipperPickedUp,
                        extraActionButtonLabel: 'Confirm Delivered',
                        extraActionButtonIcon: Icons.check,
                      ),
                      _buildOrderTab(
                        context: context,
                        status: OrderStatus.delivered,
                      ),
                      _buildOrderTab(
                        context: context,
                        status: OrderStatus.completed,
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildOrderTab({
    required BuildContext context,
    required OrderStatus status,
    String? extraActionButtonLabel,
    IconData? extraActionButtonIcon,
    bool haveCancelButton = false,
  }) {
    final orders = state.currentViewingOrders;

    if (orders.isEmpty) {
      return _buildEmptyOrdersView(context);
    }

    return RefreshIndicator(
      onRefresh: () {
        return viewModel.fetchOrders();
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: orders.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12.0),
          itemBuilder: (context, index) {
            return OrdersListItem(
              orderInfo: orders[index],
              haveCancelButton: haveCancelButton,
              extraActionButtonLabel: extraActionButtonLabel,
              extraActionButtonCallback: () => _handleAction(
                context,
                extraActionButtonLabel,
                index,
              ),
              extraActionButtonIcon: extraActionButtonIcon,
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyOrdersView(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return viewModel.fetchOrders();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: SvgPicture.asset(
                    orders_empty,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'No Order',
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

  void _handleAction(BuildContext context, String? actionLabel, int index) {
    if (actionLabel == null) return;

    // Extract the orderId from the current viewing orders
    final orderId = state.currentViewingOrders[index].order.orderId;

    // Define actions with the required orderId parameter
    final actions = {
      'Start Shipping': () => _showDialog(
            context,
            title: "Start Shipping Order",
            content: "Do you wan't to start shipping the order?",
            onConfirm: () {
              _onStartShippingOrder(orderId);
            },
          ),
      'Confirm Picked Up': () => _showDialog(
            context,
            title: "Confirm Pickup",
            content: "Are you sure the order has been picked up?",
            onConfirm: () {
              _onConfirmPickedUpOrder(orderId);
            },
          ),
      'Confirm Delivered': () => _showDialog(
            context,
            title: "Confirm Delivery",
            content: "Are you sure the order has been delivered?",
            onConfirm: () {
              _onConfirmDelivery(orderId);
            },
          ),
    };

    // Call the appropriate action based on the action label
    actions[actionLabel]?.call();
  }

  Future<void> _onConfirmDelivery(String orderId) async {
    try {
      await viewModel.confirmDeliveredOrder(orderId);

      _tabController.animateTo(3);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Order delivery confirmed successfully!'),
          duration: Duration(seconds: 1),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to confirm delivered: ${e.toString()}'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  Future<void> _onConfirmPickedUpOrder(String orderId) async {
    try {
      await viewModel.confirmPickedUpOrder(orderId);

      _tabController.animateTo(2);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Order picked up successfully!'),
          duration: Duration(seconds: 1),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to confirm pick up order: ${e.toString()}'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  Future<void> _onStartShippingOrder(String orderId) async {
    try {
      await viewModel.startShippingOrder(orderId);

      _tabController.animateTo(1);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Let\'s start delivery!'),
          duration: Duration(seconds: 1),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to start delivery: ${e.toString()}'),
          duration: const Duration(seconds: 1),
        ),
      );
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
