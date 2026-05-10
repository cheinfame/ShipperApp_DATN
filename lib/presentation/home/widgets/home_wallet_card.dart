import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../config/typography.dart';

class HomeWalletCard extends StatelessWidget {
  final double balance;

  const HomeWalletCard({
    super.key,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
        child: Row(
          children: [
            _buildBalanceColumn(context),
            const Spacer(),
            _buildTopUpButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTopUpButton(BuildContext context) {
    return Row(
      children: [
        Text(
          'Top Up',
          style: AppTypography(context: context).footnote,
        ),
        const SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: () {
            // TODO: Trigger top-up event or navigation
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
        ),
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
          NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(balance),
          style: AppTypography(context: context).title3,
        ),
      ],
    );
  }
}
