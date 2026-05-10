import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../../config/path.dart';
import '../../../config/typography.dart';
import 'package:packare_shipper/data/models/account_model.dart';

class UserDashboard extends StatelessWidget {
  final Account? account;

  const UserDashboard({
    super.key,
    required this.account,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Material(
      elevation: 8.0,
      child: Container(
        height: 250,
        width: size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorScheme.shadow,
              colorScheme.onSurfaceVariant,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildInfoRow(context, colorScheme),
              _buildWalletCart(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, ColorScheme colorScheme) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24.0,
          child: SvgPicture.asset(user_avatar),
        ),
        const SizedBox(
          width: 15.0,
        ),
        _buildHelloColumn(context, colorScheme),
        const Spacer(),
        _buildNotificationButton(colorScheme),
      ],
    );
  }

  Widget _buildHelloColumn(BuildContext context, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello',
          style: AppTypography(context: context)
              .heading1
              .copyWith(color: colorScheme.surfaceVariant),
        ),
        Text(
          account != null ? account!.user.lastName : 'User',
          style: AppTypography(context: context)
              .heading1
              .copyWith(color: colorScheme.surfaceVariant),
        ),
      ],
    );
  }

  Widget _buildNotificationButton(ColorScheme colorScheme) {
    return IconButton.outlined(
      onPressed: () {
        // TODO: Add notification trigger logic here
        // Example: Show notification details
        // You can replace the commented code below with your implementation
        // context.read<NotificationBloc>().add(GetNotificationsEvent());
      },
      icon: Badge(
        child: Icon(
          Icons.notifications_outlined,
          color: colorScheme.surface,
        ),
      ),
    );
  }

  Widget _buildWalletCart(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
        child: Row(
          children: [
            _buildBalanceColumn(context),
            const Spacer(),
            _buildTopUpRow(context)
          ],
        ),
      ),
    );
  }

  Widget _buildTopUpRow(BuildContext context) {
    return Row(
      children: [
        Text(
          'Top Up',
          style: AppTypography(context: context).footnote,
        ),
        const SizedBox(
          width: 10,
        ),
        _buildTopUpButton(context),
      ],
    );
  }

  Widget _buildBalanceColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "My balance",
          style: AppTypography(context: context).bodyText,
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(
          NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
              .format(account != null ? account!.wallet.balance : 0),
          style: AppTypography(context: context).title3,
        ),
      ],
    );
  }

  Widget _buildTopUpButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Add top-up logic here
        // Example: Navigate to a top-up screen or show a modal
        // context.read<AccountBloc>().add(TopUpEvent());
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.0),
          color: Colors.black,
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
