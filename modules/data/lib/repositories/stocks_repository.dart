import 'package:data/mappers/stock_data_dto_mapper.dart';
import 'package:data/network/responses/stock_data_response.dart';
import 'package:dependencies/dependencies.dart';
import 'package:domain/models/stock_data.dart';
import 'package:domain/network_response.dart';
import 'package:domain/repositories/stocks_repository.dart';

import '../local/dao/stock_dao.dart';
import '../network/api_service.dart';

@Injectable(as: IStockRepository)
class StockRepository implements IStockRepository {
  final ApiService apiService;
  final StockDao _stockDao;
  final StockDataDtoMapper dtoMapper = StockDataDtoMapper();

  StockRepository(this.apiService, this._stockDao);

  @override
  Future<NetworkResponse<List<StockData>>> fetchStockMarketData(
      String key, int limit, String symbols) async {
    try {
      StockDataResponse response =
          await apiService.fetchMarketStockData(key, limit, symbols);

      var stocksToSaveLocally = response.data ?? [];
      if (stocksToSaveLocally.isNotEmpty) {
        _stockDao.deleteStockData();
        _stockDao.saveAdvertItems(stocksToSaveLocally);
      }
      return NetworkResponse(true,
          data: dtoMapper.mapFromDtoListToDomain(response.data ?? []),
          extras: response.pagination?.count);
    } catch (e) {
      Fimber.e("Error fetching stock market data  $e", ex: e);
      return NetworkResponse(false);
    }
  }
}
