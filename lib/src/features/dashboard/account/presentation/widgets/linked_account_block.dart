import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/lyte_studios_flutter_ui.dart';
import 'package:tradelog_flutter/src/core/utils/tradely_number_utils.dart';
import 'package:tradelog_flutter/src/features/dashboard/account/presentation/widgets/custom_pop_menu.dart';
import 'package:tradelog_flutter/src/ui/base/base_container.dart';
import 'package:tradelog_flutter/src/ui/theme/padding_sizes.dart';

class LinkedAccountBlock extends StatefulWidget {
  final Function()? delete;

  final String name;

  final String currency;

  final double balance;

  final bool selectable;

  final bool selected;

  final Function()? onTap;

  const LinkedAccountBlock({
    super.key,
    this.delete,
    required this.name,
    required this.currency,
    required this.balance,
    this.selectable = false,
    this.selected = false,
    this.onTap,
  });

  @override
  State<LinkedAccountBlock> createState() => _LinkedAccountBlockState();
}

class _LinkedAccountBlockState extends State<LinkedAccountBlock> {
  bool isHovering = false;

  late bool selected = widget.selected;

  @override
  Widget build(BuildContext context) {
    if (widget.selected != selected) {
      selected = widget.selected;
    }

    if (!widget.selectable) {
      isHovering = false;
      selected = false;
    }

    if (selected) {
      isHovering = true;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: PaddingSizes.extraSmall,
        vertical: PaddingSizes.small,
      ),
      child: ClearInkWell(
        enabled: widget.selectable,
        onTap: () => widget.onTap?.call(),
        child: BaseContainer(
          padding: const EdgeInsets.symmetric(
            horizontal: PaddingSizes.medium,
            vertical: PaddingSizes.medium,
          ),
          outsidePadding: const EdgeInsets.only(
            bottom: PaddingSizes.medium,
          ),
          width: 210,
          borderColor: selected ? const Color(0xFF2D62FE) : null,
          backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
          borderWidth: 2,
          enableBorder: isHovering,
          child: MouseRegion(
            onEnter: (details) {
              setState(() {
                isHovering = true;
              });
            },
            onExit: (details) {
              setState(() {
                isHovering = false;
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Available balance",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontSize: 12,
                                ),
                          ),
                          const SizedBox(
                            height: PaddingSizes.xxs,
                          ),
                          Text(
                            "${TradelyNumberUtils.currencyCodeTranslation(widget.currency)} ${TradelyNumberUtils.formatValuta(widget.balance)}",
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontSize: 19,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    // Add the custom popup menu here
                    CustomPopupMenu(
                      onSelected: (String value) {
                        // Handle the selected option
                        switch (value) {
                          case 'Edit':
                            // Do something for Edit
                            break;
                          case 'Clear all trades':
                            // Do something for Clear all trades
                            break;
                          case 'Disable':
                            // Do something for Disable
                            break;
                          case 'Delete':
                            widget.delete?.call();
                            break;
                        }
                      },
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontSize: 15,
                                  ),
                        ),
                        const SizedBox(
                          height: PaddingSizes.xxs,
                        ),
                        Text(
                          "Active",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
