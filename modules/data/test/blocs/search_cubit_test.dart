import 'package:bloc_test/bloc_test.dart';
import 'package:data/blocs/search/search_cubit.dart';
import 'package:data/blocs/search/search_state.dart';
import 'package:data/dtos/stock_data_dto.dart';
import 'package:data/local/dao/stock_dao.dart';
import 'package:data/mappers/stock_data_dto_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_cubit_test.mocks.dart';

@GenerateMocks([StockDao])
void main() {
  group('Search Cubit', () {
    late StockDao stockDao;
    late SearchCubit searchCubit;
    late List<StockDataDto> stockDataDto;
    StockDataDtoMapper dtoMapper = StockDataDtoMapper();

    setUp(() {
      stockDao = MockStockDao();
      searchCubit = SearchCubit(stockDao);
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
      when(stockDao.getStockData()).thenAnswer((_) => Future.value(stockDataDto));
    });

    tearDown(() async => await searchCubit.close());

    test('on initialize, initial state is InitialSearchState', () {
      expect(searchCubit.state, InitialSearchState());
    });
    
    blocTest<SearchCubit, SearchState>(
        'on filterStockDataBySearch, and error is thrown, state is ErrorSearchState',
        build: () {
          when(stockDao.filterStockDataBySearch(
            '1',
          )).thenThrow('error');
          return searchCubit;
        },
        act: (cubit) => searchCubit.filterStockDataBySearch(
              '1',
            ),
        expect: () => [ErrorSearchState()]);


  });
}
