import 'package:tradelog_flutter/src/core/data/models/enums/tradely_enums.dart';

class TradelockerCredentialsDto {
  final String email;
  final String password;
  final String server;
  final String accountName;
  final TradingPlatform platform;

  const TradelockerCredentialsDto({
    required this.email,
    required this.password,
    required this.server,
    required this.accountName,
    required this.platform,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'server': server,
        'demo_status': platform == TradingPlatform.tradelockerDemo,
        'account_name': accountName,
      };
}
