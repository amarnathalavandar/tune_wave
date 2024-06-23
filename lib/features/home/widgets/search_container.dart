import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class TWSearchContainer extends StatelessWidget {
  const TWSearchContainer({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final twColorTheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {},
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: twColorTheme.tertiary,
          ),
          height: 60,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Ionicons.search_outline,
                  color: twColorTheme.onPrimary,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                const Text('Search song')
              ],
            ),
          )),
    );
  }
}
