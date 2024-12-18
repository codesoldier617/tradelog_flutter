import 'package:tradelog_flutter/src/core/data/models/enums/tradely_enums.dart';

class MetaApiCredentialsDto {
  final String username;
  final String password;
  final String server;
  final String accountName;
  final TradingPlatform platform;

  const MetaApiCredentialsDto({
    required this.username,
    required this.password,
    required this.server,
    required this.accountName,
    required this.platform,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'server_name': server,
        'account_name': accountName,
        'platform': platform == TradingPlatform.metaTrader5 ? 'mt5' : 'mt4',
      };
}
