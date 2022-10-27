import 'package:domain/models/stock_data.dart';
import 'package:domain/network_response.dart';


abstract class IStockRepository{

  Future<NetworkResponse<List<StockData>>> fetchStockMarketData(String key,int limit,String symbols);
}