import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:packare_shipper/presentation/authentication/global_widgets/image_view.dart';
import 'package:packare_shipper/router/app_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:packare_shipper/config/path.dart';
import 'package:packare_shipper/config/typography.dart';
import 'package:packare_shipper/data/models/order_model.dart';
import '../../map/map_screen.dart';
import '../../home/widgets/location_icon_column.dart';

class OrdersListItem extends StatelessWidget {
  final OrderWithInfo orderInfo;
  final String? extraActionButtonLabel; // Nullable
  final VoidCallback? extraActionButtonCallback; // Nullable
  final IconData? extraActionButtonIcon; // Nullable
  final bool haveCancelButton;

  const OrdersListItem({
    super.key,
    required this.orderInfo,
    this.extraActionButtonLabel,
    this.extraActionButtonCallback,
    this.extraActionButtonIcon,
    this.haveCancelButton = false,
  });

  @override
  Widget build(BuildContext context) {
    List<String> imageUrls = _getPackageImageUrls();
    List<String> packageNames = _getPackageNames();

    final cardTextStyle = AppTypography(context: context).bodyText.copyWith(
          fontSize: 14.0,
        );

    bool isShipping = _isShippingStatus(orderInfo.order.status);
    bool hasFeedback = orderInfo.order.feedback != null;

    return Material(
      elevation: 4.0,
      color: Theme.of(context).colorScheme.background,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isShipping) _buildShipperInfo(cardTextStyle),
            const SizedBox(height: 8.0),
            if (isShipping) _buildReceiverInfo(cardTextStyle, hasFeedback),
            if (isShipping) const Divider(),
            _buildOrderDetails(context, cardTextStyle, imageUrls, packageNames),
            const SizedBox(height: 12.0),
            if (orderInfo.order.status != OrderStatus.completed)
              _buildActionButtons(context, imageUrls, packageNames),
          ],
        ),
      ),
    );
  }

  List<String> _getPackageImageUrls() {
    return orderInfo.order.packages
        .where((package) =>
            package.packageImageUrl != null &&
            package.packageImageUrl!.isNotEmpty)
        .map((package) => package.packageImageUrl!)
        .toList();
  }

  List<String> _getPackageNames() {
    return orderInfo.order.packages
        .where((package) =>
            package.packageImageUrl != null &&
            package.packageImageUrl!.isNotEmpty)
        .map((package) => package.packageName)
        .toList();
  }

  double _calculateHoldingFee() {
    return orderInfo.order.packages.fold(0.0, (sum, package) {
      return sum + package.packagePrice;
    });
  }

  bool _isShippingStatus(OrderStatus status) {
    return [
      OrderStatus.startShipping,
      OrderStatus.shipperAccepted,
      OrderStatus.shipperPickedUp,
      OrderStatus.delivered,
    ].contains(status);
  }

  Widget _buildShipperInfo(TextStyle cardTextStyle) {
    return Row(
      children: [
        CircleAvatar(
          radius: 18.0,
          child: SvgPicture.asset(user_avatar),
        ),
        const SizedBox(width: 15.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Sender",
                style: cardTextStyle.copyWith(fontWeight: FontWeight.w600)),
            Text(
                "${orderInfo.order.sender?.user.firstName ?? ""} ${orderInfo.order.sender?.user.lastName ?? ""}",
                style: cardTextStyle),
            Text(orderInfo.order.sender?.user.phoneNumber ?? "",
                style: cardTextStyle),
          ],
        ),
        const Spacer(),
        if (orderInfo.order.feedback == null)
          IconButton(
            onPressed: () {
              String phoneNumber = orderInfo.order.sender!.user.phoneNumber;
              String uri = "tel:$phoneNumber";
              launchUrl(Uri.parse(uri));
            },
            icon: Icon(
              Icons.phone,
              color: Colors.blue[800],
            ),
          )
        else
          _buildFeedbackSection(cardTextStyle),
      ],
    );
  }

  Widget _buildFeedbackSection(TextStyle cardTextStyle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Feedback",
            style: cardTextStyle.copyWith(fontWeight: FontWeight.w600)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return Icon(
              index < orderInfo.order.feedback!.rating
                  ? Icons.star
                  : Icons.star_border,
              color: Colors.orange[400],
            );
          }),
        ),
        Text(orderInfo.order.feedback!.comment, style: cardTextStyle),
      ],
    );
  }

  Widget _buildReceiverInfo(TextStyle cardTextStyle, bool hasFeedback) {
    return Row(
      children: [
        CircleAvatar(
          radius: 18.0,
          child: SvgPicture.asset(user_avatar),
        ),
        const SizedBox(width: 15.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Receiver",
                style: cardTextStyle.copyWith(fontWeight: FontWeight.w600)),
            Text(orderInfo.order.receiverName, style: cardTextStyle),
            Text(orderInfo.order.receiverPhone, style: cardTextStyle),
          ],
        ),
        const Spacer(),
        if (!hasFeedback)
          IconButton(
            onPressed: () {
              String phoneNumber = orderInfo.order.receiverPhone;
              String uri = "tel:$phoneNumber";
              launchUrl(Uri.parse(uri));
            },
            icon: Icon(
              Icons.phone,
              color: Colors.blue[800],
            ),
          ),
      ],
    );
  }

  Widget _buildOrderDetails(BuildContext context, TextStyle cardTextStyle,
      List<String> imageUrls, List<String> packageNames) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildOrderIdRow(context),
        const SizedBox(height: 5.0),
        buildLocationIconColumn(
          context,
          orderInfo.order.sendAddress,
          orderInfo.order.deliveryAddress,
        ),
        const SizedBox(height: 8.0),
        _buildPackagesInfo(cardTextStyle, packageNames),
        _buildStatusInfo(cardTextStyle),
        _buildShippingFeeInfo(cardTextStyle),
        _buildHoldingFeeInfo(cardTextStyle),
      ],
    );
  }

  Widget _buildOrderIdRow(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(
            width: 52,
            child: SvgPicture.asset(packare_logo_path, height: 24, width: 24),
          ),
          SelectableText(
            orderInfo.order.orderId,
            style: AppTypography(context: context).title1.copyWith(fontSize: 18),
          ),
          IconButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: orderInfo.order.orderId));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Order ID copied to clipboard')),
              );
            },
            icon: Icon(
              Icons.copy,
              color: Theme.of(context).colorScheme.outline,
            ),
            iconSize: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildPackagesInfo(
      TextStyle cardTextStyle, List<String> packageNames) {
    return Padding(
      padding: const EdgeInsets.only(left: 52.0),
      child: Text("Packages: ${packageNames.join(', ')}", style: cardTextStyle),
    );
  }

  Widget _buildStatusInfo(TextStyle cardTextStyle) {
    return Padding(
      padding: const EdgeInsets.only(left: 52.0),
      child: Text(
        "Status: ${orderInfo.order.status.toString().split('.').last}",
        style: cardTextStyle,
      ),
    );
  }

  Widget _buildShippingFeeInfo(TextStyle cardTextStyle) {
    return Padding(
      padding: const EdgeInsets.only(left: 52.0),
      child: Text("Shipping fee: \$${orderInfo.order.shippingPrice}",
          style: cardTextStyle),
    );
  }

  Widget _buildHoldingFeeInfo(TextStyle cardTextStyle) {
    return Padding(
      padding: const EdgeInsets.only(left: 52.0),
      child: Text("Holding fee: \$${_calculateHoldingFee()}",
          style: cardTextStyle),
    );
  }

  Widget _buildActionButtons(
      BuildContext context, List<String> imageUrls, List<String> packageNames) {
    return Wrap(
      alignment: WrapAlignment.end,
      spacing: 8.0, // Horizontal spacing between buttons
      runSpacing: 8.0, // Vertical spacing between wrapped buttons
      children: [
        const SizedBox(width: double.infinity),
        _buildPackageImagesButton(context, imageUrls, packageNames),
        // _buildMapButton(context),
        if (extraActionButtonLabel != null) _buildExtraActionButton(context),
        // If shipper just accepcted the orderInfo.order.order and hasn't start shipping it, it can be cancel
        if (haveCancelButton) _buildCancelButton(context),
      ],
    );
  }

  Widget _buildExtraActionButton(BuildContext context) {
    final cardTextStyle = AppTypography(context: context).bodyText.copyWith(
          fontSize: 14.0,
        );
    return TextButton.icon(
      onPressed: extraActionButtonCallback,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.blue[300]),
      ),
      icon: Icon(
        extraActionButtonIcon,
        color: Colors.blue[900],
        size: 16.0,
      ),
      label: Text(
        extraActionButtonLabel ?? '',
        style: cardTextStyle.copyWith(color: Colors.blue[900]),
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    final cardTextStyle = AppTypography(context: context).bodyText.copyWith(
          fontSize: 14.0,
        );
    return TextButton.icon(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Cancel Order"),
              content: Text(
                  "Are you sure you want to cancel this orderInfo.order.order.orderInfo.order.order?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text(
                    "No",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    // Close the dialog
                    Navigator.of(context).pop();

                    // Cover backend cancel

                    // Wait for the cancellation process
                    await Future.delayed(Duration(seconds: 1));

                    // Check the cancellation status

                    // Cover current shipping orderInfo.order.order.orderInfo.order.order of shipper UI
                  },
                  child: Text(
                    "Yes",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ],
            );
          },
        );
      },
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.red[200]),
      ),
      icon: Icon(
        Icons.cancel,
        color: Colors.red[900],
        size: 16.0,
      ),
      label: Text(
        "Cancel",
        style: cardTextStyle.copyWith(color: Colors.red[900]),
      ),
    );
  }

  Widget _buildPackageImagesButton(
      BuildContext context, List<String> imageUrls, List<String> packageNames) {
    final cardTextStyle = AppTypography(context: context).bodyText.copyWith(
          fontSize: 14.0,
        );
    return TextButton.icon(
      onPressed: imageUrls.isNotEmpty
          ? () {
              // Open PackageImageScreen when button is pressed
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ImageView(
                    imageUrls: imageUrls,
                    imageNames: packageNames,
                  ),
                ),
              );
            }
          : null,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.blue[300]),
      ),
      icon: Icon(
        Icons.picture_in_picture_alt,
        color: Colors.blue[900],
        size: 16.0,
      ),
      label: Text(
        "Packages Picture",
        style: cardTextStyle.copyWith(color: Colors.blue[900]),
      ),
    );
  }

  // Widget _buildMapButton(BuildContext context) {
  //   final cardTextStyle = AppTypography(context: context).bodyText.copyWith(
  //         fontSize: 14.0,
  //       );

  //   return TextButton.icon(
  //     onPressed: () {
  //       context.pushRoute(MapRoute(orderInfo: orderInfo));
  //     },
  //     style: ButtonStyle(
  //       backgroundColor: MaterialStatePropertyAll(Colors.blue[300]),
  //     ),
  //     icon: Icon(
  //       Icons.map,
  //       color: Colors.blue[900],
  //       size: 16.0,
  //     ),
  //     label: Text(
  //       "Route",
  //       style: cardTextStyle.copyWith(color: Colors.blue[900]),
  //     ),
  //   );
  // }
}
