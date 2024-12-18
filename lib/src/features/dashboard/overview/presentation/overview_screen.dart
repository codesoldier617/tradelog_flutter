import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/theme/extensions/hex_color.dart';
import 'package:tradelog_flutter/src/core/data/models/dto/users/overview_statistics_dto.dart';
import 'package:tradelog_flutter/src/core/data/services/users_service.dart';
import 'package:tradelog_flutter/src/core/mixins/screen_state_mixin.dart';
import 'package:tradelog_flutter/src/features/authentication/screens/paywall_dialog.dart';
import 'package:tradelog_flutter/src/features/dashboard/my_trades/presentation/add_trade_dialog.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/base_data_container.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/chart_container.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/data_container.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/holding_container.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/long_short_container.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/containers/progress_data_container.dart';
import 'package:tradelog_flutter/src/features/dashboard/overview/presentation/widgets/web_statistic_chart.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page.dart';
import 'package:tradelog_flutter/src/ui/base/base_tradely_page_header.dart';
import 'package:tradelog_flutter/src/ui/buttons/primary_button.dart';
import 'package:tradelog_flutter/src/ui/icons/tradely_icons.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  static const String route = '/$location';
  static const String location = 'overview';

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> with ScreenStateMixin {
  OverviewStatisticsDto? statistics;

  @override
  Future<void> loadData() async {
    statistics = await UsersService().getAccountStatistics();

    setState(() {
      statistics = statistics;
    });
    return super.loadData();
  }

  @override
  Widget build(BuildContext context) {
    loading = true;

    return BaseTradelyPage(
      header: BaseTradelyPageHeader(
        subTitle: "Discover all your performance metrics & progress.",
        icon: TradelyIcons.overview,
        currentRoute: OverviewScreen.location,
        title: "Good morning${(true) ? '' : ' ${'Tanguy' ?? ''}'}!",
        titleIconPath: 'assets/images/emojis/hand_emoji.png',
        buttons: PrimaryButton(
          onTap: () => AddTradeDialog.show(context),
          height: 42,
          text: "Add new trade",
          prefixIcon: TradelyIcons.plusCircle,
          prefixIconSize: 22,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 480,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 140,
                        child: Row(
                          children: [
                            DataContainer(
                              title: 'Net Profit/Loss',
                              toolTip:
                                  'The total realized net profit and loss for all closed trades.',
                              value: statistics?.overallStatistics.totalProfit,
                              loading: loading,
                            ),
                            DataContainer(
                              title: 'Trade win rate',
                              toolTip:
                                  'Reflects the percentage of your winning trades out of total trades taken.',
                              value: statistics?.overallStatistics.winRate,
                              loading: loading,
                            ),
                            ProgressDataContainer(
                              title: ' Avg realized R:R',
                              toolTip:
                                  'Average Win / Average Loss = Average Realize R:R',
                              value:
                                  (statistics?.overallStatistics.totalProfit ??
                                          0) /
                                      (statistics?.overallStatistics
                                              .totalInvested ??
                                          1),
                              loading: loading,
                            )
                          ],
                        ),
                      ),
                      ChartContainer(
                        title: 'Equity line',
                        toolTip:
                            "Your equity line shows your account’s value over time, highlighting profits and losses.",
                        data: {},
                        balance: null,
                        loading: loading,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      LongShortContainer(
                        long: 0,
                        short: 0,
                        averageWin: 0,
                        bestWin: 0,
                        bestLoss: 0,
                        averageWinStreak: 0,
                        maxWinStreak: 0,
                        loading: loading,
                      ),
                      HoldingContainer(
                        holdingTime: 0,
                        loading: loading,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 360,
            child: Row(
              children: [
                BaseDataContainer(
                  title: 'Weekday',
                  toolTip: '',
                  child: Expanded(
                    child: WebStatisticChart(
                      data: statistics?.weekDistribution ??
                          {
                            'Monday': 0,
                            'Tuesday': 0,
                            'Wednesday': 0,
                            'Thursday': 0,
                            'Friday': 0,
                            'Saturday': 0,
                          },
                    ),
                  ),
                ),
                BaseDataContainer(
                  title: 'Sessions',
                  toolTip: '',
                  child: Expanded(
                    child: WebStatisticChart(
                      color: HexColor.fromHex('#FFCC00'),
                      data: const {
                        'London': 4,
                        'New York': 2,
                        'Asia': 2,
                        'Pacific': 5,
                      },
                    ),
                  ),
                ),
                BaseDataContainer(
                  title: 'Pairs',
                  toolTip: '',
                  child: Expanded(
                    child: WebStatisticChart(
                      data: statistics?.toSymbolChartMap() ??
                          OverviewStatisticsDto.getDefaultSymbolChartMap(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _showPaywallDialog(BuildContext context) async {
  await showDialog(
    context: context,
    barrierDismissible:
        false, // Prevent dismissing the dialog by tapping outside
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: const PaywallDialog(),
      );
    },
  );
}
