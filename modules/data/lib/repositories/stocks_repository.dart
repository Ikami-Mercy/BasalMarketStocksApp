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
      var formattedResponse = response.data?.map((stockData) {
        if (stockData.date != null) {
          stockData.date = DateFormat('yyyy-MM-dd HH:mm:ss')
              .format(DateTime.parse(stockData.date!));
        }
        return stockData;
      }).toList();
      var stocksToSaveLocally = formattedResponse ?? [];
      if (stocksToSaveLocally.isNotEmpty) {
        _stockDao.deleteStockData();
        _stockDao.saveStocks(stocksToSaveLocally);
      }
      return NetworkResponse(true,
          data: dtoMapper.mapFromDtoListToDomain(formattedResponse ?? []),
          extras: response.pagination?.count);
    } on DioError catch (dioError) {
      var errorMessage = dioError.message;
      var responseStatusCode = dioError.response?.statusCode;
      if (errorMessage.toString().contains('SocketException')) {
        return NetworkResponse(false, error: 'You have no internet connection');
      }
      if (responseStatusCode == 401) {
        return NetworkResponse(false,
            error: 'An invalid API access key was supplied');
      } else if (responseStatusCode == 403) {
        return NetworkResponse(false,
            error: 'Access is not supported on the current subscription plan');
      } else if (responseStatusCode == 404) {
        return NetworkResponse(false, error: 'Resource not found.');
      } else if (responseStatusCode == 429) {
        return NetworkResponse(false,
            error: 'Your user account has reached the rate limit.');
      } else if (responseStatusCode == 500) {
        return NetworkResponse(false, error: 'A server error occurred.');
      } else {
        return NetworkResponse(false);
      }
    } catch (e) {
      Fimber.e("Error fetching stock market data  $e", ex: e);
      return NetworkResponse(false);
    }
  }
}
