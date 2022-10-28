import 'package:data/dtos/stock_data_dto.dart';
import 'package:data/local/app_database.dart';
import 'package:data/local/dao/stock_dao.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Stock Dao', () {
    late AppDatabase appDatabase;
    late StockDao stockDao;

    setUp(() async {
      appDatabase = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
      stockDao = appDatabase.stockDao;
    });

    tearDown(() async => await appDatabase.close());

    test('getStockItems, and no stock item exist, returns null',
            () async {
          var stocks = await stockDao.getStockData();
          expect(stocks.length, 0);
        });

    test('getStockItems, and stocks exists, returns stocks', () async {
      var stockDto = StockDataDto(
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
      await stockDao.saveStocks([stockDto]);
      var stock = await stockDao.getStockData();
      expect(stock.length, 1);
    });

    test('on delete stocks, should remove all DB records', () async {
      var stockDto = StockDataDto(
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
      await stockDao.saveStocks([stockDto]);

      await stockDao.deleteStockData();

      var stocks = await stockDao.getStockData();
      expect(stocks.length, 0);
    });
  });
}
