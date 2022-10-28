import 'package:bloc_test/bloc_test.dart';
import 'package:data/blocs/stocks/stock_cubit.dart';
import 'package:data/blocs/stocks/stock_state.dart';
import 'package:data/dtos/stock_data_dto.dart';
import 'package:data/local/dao/stock_dao.dart';
import 'package:data/mappers/stock_data_dto_mapper.dart';
import 'package:dependencies/dependencies.dart';
import 'package:domain/network_response.dart';
import 'package:domain/repositories/stocks_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'stock_cubit_test.mocks.dart';


@GenerateMocks([StockDao,IStockRepository])
void main() {
  group('Stock Cubit', () {
    late StockDao stockDao;
    late StockCubit stockCubit;
    late IStockRepository stockRepository;

    TestWidgetsFlutterBinding.ensureInitialized();
    dotenv.testLoad(mergeWith: {'MARKET_STACK_API_KEY': 'testKey'});

    setUp(() {
      stockDao = MockStockDao();
      stockRepository = MockIStockRepository();
      stockCubit = StockCubit(stockRepository,stockDao);
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
      when(stockDao.getStockData()).thenAnswer((_) => Future.value([]));
    });

    tearDown(() async => await stockCubit.close());

    blocTest<StockCubit, StockState>(
        'on loadStockMarketData, and error is thrown, state is LoadingStockState then ErrorStockState',
        build: () {
          when(stockRepository.fetchStockMarketData(
            'testKey',3,'1'
          )).thenAnswer((_) async => NetworkResponse(false,error: 'error'));

          return stockCubit;
        },
        act: (cubit) => stockCubit.loadStockMarketData(
        ),
        expect: () => [LoadingStockState(),const ErrorStockState(errorMessage: 'Unexpected error occurred')]);

    blocTest<StockCubit, StockState>(
        'on loadLocalStockMarketData, and local data is empty, state emitted is LoadingStockState then EmptyStockState',
        build: () {
          when(stockDao.getStockData(
          )).thenAnswer((_) async => Future.value([]));
          return stockCubit;
        },
        act: (cubit) => stockCubit.loadLocalStockMarketData(
        ),
        expect: () => [LoadingStockState()]);


    blocTest<StockCubit, StockState>(
        'on filterStockDataByDate, and filtered data is empty, state emitted is LoadingStockState then EmptyStockFilteredState',
        build: () {
          when(stockDao.filterStockDataByDate(
              '2022-10-21 00:00:00','2022-10-21 00:00:00'
          )).thenAnswer((_) async => Future.value([]));
          return stockCubit;
        },
        act: (cubit) => stockCubit.filterStockDataByDate(
            '2022-10-21 00:00:00','2022-10-21 00:00:00'
        ),
        expect: () => [LoadingStockState(), EmptyStockFilteredState()]);

    blocTest<StockCubit, StockState>(
        'on filterStockDataByDate, and an error is thrown, state emitted is LoadingStockState then ErrorStockState',
        build: () {
          when(stockDao.filterStockDataByDate(
              '2022-10-21 00:00:00','2022-10-21 00:00:00'
          )).thenThrow('error');
          return stockCubit;
        },
        act: (cubit) => stockCubit.filterStockDataByDate(
            '2022-10-21 00:00:00','2022-10-21 00:00:00'
        ),
        expect: () => [LoadingStockState(), const ErrorStockState(errorMessage: 'Unexpected error occurred')]);

  });
}
