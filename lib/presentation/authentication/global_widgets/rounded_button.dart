import 'package:flutter/material.dart';
import '../../../config/typography.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    required this.text,
    required this.onTap,
    this.widthFactor = 0.6,
    this.heightFactor = 0.06,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0), // Added default padding
  });

  final String text;
  final VoidCallback onTap;
  final double widthFactor;
  final double heightFactor;
  final double borderRadius;
  final EdgeInsetsGeometry padding; // Padding parameter

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * widthFactor,
      height: MediaQuery.of(context).size.height * heightFactor,
      child: Ink(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onTap,
          child: Padding(
            padding: padding,
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: AppTypography(context: context).bodyText.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
