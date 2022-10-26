import 'package:domain/models/stock_data.dart';
import 'package:domain/network_response.dart';
import 'package:dependencies/dependencies.dart';

@injectable
abstract class IStockRepository{

  Future<NetworkResponse<List<StockData>>> fetchStockMarketData(String key, String sort, String symbols);
}