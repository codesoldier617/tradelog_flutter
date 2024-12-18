import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tradelog_flutter/src/ui/base/base_container_expanded.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class SmallDataContainer extends StatelessWidget {
  final String title;

  final String? data;

  final bool? positive;

  final bool blurred;

  final bool loading;

  const SmallDataContainer({
    super.key,
    required this.title,
    this.data,
    this.positive,
    this.blurred = false,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    return BaseContainerExpanded(
      loading: loading,
      height: 100,
      padding: const EdgeInsets.all(
        PaddingSizes.large,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.titleMedium?.copyWith(
              fontSize: 12,
            ),
          ),
          if (blurred)
            ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: 5,
                sigmaY: 5,
              ),
              child: const Text("N/A"),
            ),
          if (!blurred)
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 42,
                  ),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      data != null ? data! : "-",
                      style: textTheme.bodyLarge?.copyWith(
                        fontSize: 35,
                        color: positive != null
                            ? positive!
                                ? colorScheme.tertiary
                                : colorScheme.error
                            : null,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
