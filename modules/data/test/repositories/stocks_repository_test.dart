import 'package:data/dtos/stock_data_dto.dart';
import 'package:data/local/dao/stock_dao.dart';
import 'package:data/network/api_service.dart';
import 'package:data/network/responses/stock_data_response.dart';
import 'package:data/repositories/stocks_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'stocks_repository_test.mocks.dart';

@GenerateMocks([ApiService, StockDao])
void main() {
  group('Stocks Repository', () {
    late ApiService apiService;
    late StockDao stockDao;
    late StockRepository stockRepository;
    late List<StockDataDto> stockDataDto;

    setUp(() {
      apiService = MockApiService();
      stockDao = MockStockDao();
      stockRepository = StockRepository(apiService, stockDao);
      stockDataDto = <StockDataDto>[
        StockDataDto(
            open: 1.0,
            close: 1.0,
            high: 1.0,
            low: 1.0,
            last: 1.0,
            volume: 1.0,
            exchange: 'test',
            date: '2022-10-21T00:00:00+0000',
            symbol: 'test')
      ];
    });
    test('on fetchStockMarketData, and is successful, should return true',
        () async {
      when(apiService.fetchMarketStockData('key', 2, 'symbols')).thenAnswer(
          (_) async => Future.value(StockDataResponse(stockDataDto, null)));
      var response =
          await stockRepository.fetchStockMarketData('key', 2, 'symbols');
      expect(response.success, true);
    });
    test(
        'on fetchStockMarketData, and response is successful, should return the same received stockDataList size ',
            () async {
          when(apiService.fetchMarketStockData('key', 2, 'symbols'))
              .thenAnswer((_) async => Future.value(StockDataResponse(stockDataDto, null)));
          var response =
          await stockRepository.fetchStockMarketData('key', 2, 'symbols');
          expect(response.data?.length, stockDataDto.length);
        });
    test('on fetchStockMarketData, and is successful, should not return error',
            () async {
              when(apiService.fetchMarketStockData('key', 2, 'symbols')).thenAnswer(
                      (_) async => Future.value(StockDataResponse(stockDataDto, null)));
              var response =
              await stockRepository.fetchStockMarketData('key', 2, 'symbols');
              expect(response.error, null);
        });
    test('on fetchStockMarketData, and exception is thrown, should return false',
            () async {
          when(apiService.fetchMarketStockData('key', 2, 'symbols')).thenThrow('error');
          var response =
          await stockRepository.fetchStockMarketData('key', 2, 'symbols');
          expect(response.success, false);
        });
  });
}
