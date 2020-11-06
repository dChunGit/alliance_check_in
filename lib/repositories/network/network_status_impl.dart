import 'package:data_connection_checker/data_connection_checker.dart';
import 'network_status.dart';

class NetworkStatusImpl implements NetworkStatus {
  final DataConnectionChecker connectionChecker;

  NetworkStatusImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}