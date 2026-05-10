import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:packare_shipper/data/models/order_model.dart';
import 'package:packare_shipper/presentation/orders/widgets/orders_list_item.dart';

class OrderPageViewList extends StatelessWidget {
  final PageController orderPageController;
  final List<OrderWithInfo> orders;
  final String extraActionButtonLabel;
  final Function(OrderWithInfo) extraActionButtonCallback;
  final IconData extraActionButtonIcon;
  final double? height;
  const OrderPageViewList({
    Key? key,
    required this.orderPageController,
    required this.orders,
    required this.extraActionButtonLabel,
    required this.extraActionButtonCallback,
    required this.extraActionButtonIcon,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 500,
          child: PageView.builder(
            controller: orderPageController,
            itemCount: orders.length,
            itemBuilder: (context, index) => OrdersListItem(
              orderInfo: orders[index],
              extraActionButtonCallback: () => extraActionButtonCallback(orders[index]),
              extraActionButtonIcon: extraActionButtonIcon,
              extraActionButtonLabel: extraActionButtonLabel,
            ),
          ),
        ),
        Center(
          child: SmoothPageIndicator(
            controller: orderPageController,
            count: orders.length,
            effect: WormEffect(),
          ),
        ),
      ],
    );
  }
}
