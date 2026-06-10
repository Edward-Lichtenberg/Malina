import 'package:connectivity_plus/connectivity_plus.dart';

/// Абстракция для проверки подключения к интернету
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

/// Реализация проверки интернета через пакет connectivity_plus
class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected async {
    final result = await connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
