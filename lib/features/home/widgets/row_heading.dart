import 'package:flutter/material.dart';

class TWRowHeading extends StatelessWidget {
  const TWRowHeading({
    super.key,
    required this.leftHeading,
    required this.rightHeading,
  });

  final String leftHeading;
  final String rightHeading;

  @override
  Widget build(BuildContext context) {
    final twTextTheme = Theme.of(context).textTheme;
    final twColorTheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(leftHeading,style: twTextTheme.titleMedium,),
        Text(rightHeading,style: twTextTheme.titleMedium?.copyWith(color: twColorTheme.onTertiary),)
      ],
    );
  }
}
