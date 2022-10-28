import 'package:data/dtos/stock_data_dto.dart';
import 'package:data/mappers/stock_data_dto_mapper.dart';
import 'package:domain/models/stock_data.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('StockData Mapper', () {
    late StockDataDto stockDto;
    late StockData stock;
    late StockDataDtoMapper stockDtoMapper;

    setUp(() {
      stock = StockData(
          open: 1.0,
          close: 1.0,
          high: 1.0,
          low: 1.0,
          last: 1.0,
          volume: 1.0,
          exchange: 'test',
          date: '2022-10-21T00:00:00+0000',
          symbol: 'test'
      );

      stockDto = StockDataDto(
          open: 1.0,
          close: 1.0,
          high: 1.0,
          low: 1.0,
          last: 1.0,
          volume: 1.0,
          exchange: 'test',
          date: '2022-10-21T00:00:00+0000',
          symbol: 'test'
      );

      stockDtoMapper = StockDataDtoMapper();
    });

    test('map to dto should return object with same values', () {
      var dto = stockDtoMapper.mapToDto(stock);
      expect(dto.exchange, 'test');
      expect(dto.symbol, 'test');
    });

    test('map from dto should return object with same values', () {
      var stock = stockDtoMapper.mapFromDto(stockDto);
      expect(stock.exchange, 'test');
      expect(stock.symbol, 'test');
    });

  });
}