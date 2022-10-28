import 'package:data/dtos/stock_data_dto.dart';
import 'package:data/mappers/stock_data_dto_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StockDataDto', () {
    test('fromJson generates StockDataDto object', () {
      var json = {
        "open": 35.42,
        "high": 36.09,
        "low": 35.35,
        "close": 35.7,
        "volume": 41113539.0,
        "adj_high": 36.09,
        "adj_low": 35.35,
        "adj_close": 35.7,
        "adj_open": 35.42,
        "adj_volume": 41113536.0,
        "split_factor": 1.0,
        "dividend": 0.0,
        "symbol": "BAC",
        "exchange": "XNYS",
        "date": "2022-10-26T00:00:00+0000"
      };

      var stockData = StockDataDto.fromJson(json);

      expect(stockData.symbol, 'BAC');
      expect(stockData.open, 35.42);
    });

    test('toDomain generates StockData domain object', () {
      var stockDataDto = StockDataDto(
          open: 1.0,
          close: 1.0,
          high: 1.0,
          low: 1.0,
          last: 1.0,
          volume: 1.0,
          exchange: 'test',
          date: '2022-10-21T00:00:00+0000',
          symbol: 'test');

      StockDataDtoMapper stockDataDtoMapper = StockDataDtoMapper();
      var stockData = stockDataDtoMapper.mapFromDto(stockDataDto);
      expect(stockData.volume, 1.0);
      expect(stockData.last, 1.0);
    });
  });
}
