import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../config/typography.dart';
import '../../../data/models/order_model.dart';

class ShipperHomeOrderListItem extends StatefulWidget {
  final OrderWithInfo orderInfo;
  final String compatibleRouteName;
  final VoidCallback onAcceptOrderTapped;

  const ShipperHomeOrderListItem({
    Key? key,
    required this.orderInfo,
    required this.compatibleRouteName,
    required this.onAcceptOrderTapped,
  }) : super(key: key);

  @override
  State<ShipperHomeOrderListItem> createState() =>
      _ShipperHomeOrderListItemState();
}

class _ShipperHomeOrderListItemState extends State<ShipperHomeOrderListItem> {
  double holdingFee = 0.00;
  List<String> packagesName = [];

  String _formatDateTime(
    DateTime dateTime,
  ) {
    return DateFormat('M/d HH:mm').format(dateTime);
  }

  @override
  void initState() {
    super.initState();

    for (var e in widget.orderInfo.order.packages) {
      holdingFee += e.packagePrice;
      packagesName.add(e.packageName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cardTextStyle = AppTypography(context: context).bodyText.copyWith(
          fontSize: 14.0,
        );
    final cardTextStyleBold = AppTypography(context: context)
        .bodyText
        .copyWith(fontSize: 14.0, fontWeight: FontWeight.w600);

    return Material(
      elevation: 2.0,
      color: Theme.of(context).colorScheme.background,
      borderRadius: BorderRadius.circular(12.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildDetails(cardTextStyle, cardTextStyleBold),
          Positioned(
            right: 8,
            child: _buildTakeOrderButton(cardTextStyle),
          ),
        ],
      ),
    );
  }

  Widget _buildDetails(TextStyle cardTextStyle, TextStyle cardTextStyleBold) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.fromLTRB(0, 15.0, 15.0, 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildShippingIconContainer(),
          _buildDetailsColumn(cardTextStyle, cardTextStyleBold),
        ],
      ),
    );
  }

  Widget _buildDetailsColumn(TextStyle cardTextStyle, TextStyle cardTextStyleBold) {  
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHoldingFeeText(cardTextStyle, cardTextStyleBold),
        _buildShippingPriceText(cardTextStyle, cardTextStyleBold),
        _buildCompatibleRouteNameText(cardTextStyle, cardTextStyleBold),
        _buildExpandingDistanceText(cardTextStyle, cardTextStyleBold),
        _buildPickupTimeText(cardTextStyle, cardTextStyleBold),
        _buildDeliveryTimeText(cardTextStyle, cardTextStyleBold),
      ],
    );
  }

  Widget _buildHoldingFeeText(
      TextStyle cardTextStyle, TextStyle cardTextStyleBold) {
    return RichText(
      text: TextSpan(
        text: "Holding Fee: ",
        style: cardTextStyle,
        children: [
          TextSpan(
              text: NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                  .format(holdingFee),
              style: cardTextStyleBold),
        ],
      ),
    );
  }

  Widget _buildShippingPriceText(
      TextStyle cardTextStyle, TextStyle cardTextStyleBold) {
    return RichText(
      text: TextSpan(
        text: "Shipping Price: ",
        style: cardTextStyle,
        children: [
          TextSpan(
              text: NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                  .format(widget.orderInfo.order.shippingPrice),
              style: cardTextStyleBold),
        ],
      ),
    );
  }

  Widget _buildCompatibleRouteNameText(
      TextStyle cardTextStyle, TextStyle cardTextStyleBold) {
    return RichText(
      text: TextSpan(
        text: "Compatible Route: ",
        style: cardTextStyle,
        children: [
          TextSpan(
            text: widget.compatibleRouteName,
            style: cardTextStyleBold,
          ),
        ],
      ),
    );
  }

  Widget _buildExpandingDistanceText(
      TextStyle cardTextStyle, TextStyle cardTextStyleBold) {
    return RichText(
      text: TextSpan(
        text: "Expanding Distance: ",
        style: cardTextStyle,
        children: [
          TextSpan(
            text: widget.orderInfo.distance < 1
                ? '${(widget.orderInfo.distance * 1000).toStringAsFixed(0)} m'
                : '${widget.orderInfo.distance.toStringAsFixed(2)} km',
            style: cardTextStyleBold,
          ),
        ],
      ),
    );
  }

  Widget _buildPickupTimeText(
      TextStyle cardTextStyle, TextStyle cardTextStyleBold) {
    return RichText(
      text: TextSpan(
        text: "Pick Up Time: ",
        style: cardTextStyle,
        children: [
          TextSpan(
            text: _formatDateTime(
                widget.orderInfo.order.preferredPickupStartTime!),
            style: cardTextStyleBold,
          ),
          TextSpan(
            text: " - ",
            style: cardTextStyle,
          ),
          TextSpan(
            text:
                _formatDateTime(widget.orderInfo.order.preferredPickupEndTime!),
            style: cardTextStyleBold,
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryTimeText(
      TextStyle cardTextStyle, TextStyle cardTextStyleBold) {
    return RichText(
      text: TextSpan(
        text: "Delivery Time: ",
        style: cardTextStyle,
        children: [
          TextSpan(
            text: _formatDateTime(
                widget.orderInfo.order.preferredDeliveryStartTime!),
            style: cardTextStyleBold,
          ),
          TextSpan(
            text: " - ",
            style: cardTextStyle,
          ),
          TextSpan(
            text: _formatDateTime(
                widget.orderInfo.order.preferredDeliveryEndTime!),
            style: cardTextStyleBold,
          ),
        ],
      ),
    );
  }

  Widget _buildShippingIconContainer() {
    return Container(
      margin: const EdgeInsets.only(left: 15.0, right: 15.0),
      alignment: Alignment.center,
      height: 82,
      width: 48,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Center(
        child: Icon(
          Icons.local_shipping_rounded,
          color: Theme.of(context).colorScheme.primary,
          size: 32.0,
        ),
      ),
    );
  }

  Widget _buildTakeOrderButton(TextStyle cardTextStyle) {
    return TextButton(
      onPressed: () {
        // Show a confirmation dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Confirm Order Acceptance"),
              content: Text("Are you sure you want to accept this order?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    // Dispatch the AcceptOrderEvent
                    widget.onAcceptOrderTapped();

                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text("Accept"),
                ),
              ],
            );
          },
        );
      },
      child: Text(
        "Take Order",
        style: cardTextStyle.copyWith(
          color: Theme.of(context).colorScheme.tertiary,
          fontSize: 12.0,
        ),
      ),
    );
  }
}
