import 'package:basal_test/ui/screens/stocks_market_page.dart';
import 'package:data/blocs/internet/network_bloc.dart';
import 'package:data/blocs/internet/network_state.dart';
import 'package:data/blocs/stocks/stock_cubit.dart';
import 'package:data/blocs/stocks/stock_state.dart';
import 'package:dependencies/dependencies.dart';
import 'package:domain/models/stock_data.dart';
import 'package:domain/network_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'stocks_market_page_test.mocks.dart';
import 'test_utils.dart';

@GenerateMocks([StockCubit, NetworkState])
void main() {
  group('StockMarketPage Screen', ()
  {
    late StockCubit stockCubit;
    late List<StockData> stockData;

    setUp(() {
      stockCubit = MockStockCubit();
      stockData = <StockData>[
        StockData(
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
      when(stockCubit.state).thenReturn(InitialStockState());

      when(stockCubit.stream)
          .thenAnswer((_) => Stream.fromIterable([InitialStockState()]));
    });

    tearDown(() async {
      await stockCubit.close();
    });

    testWidgets(
      'on create StockMarketPage, StockMarketPage UI  should be shown',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MultiBlocProvider(
            providers: [
              BlocProvider(create: (ctx) => stockCubit),
              BlocProvider(create: (ctx) => NetworkBloc()),
            ],
            child: buildTestableWidget(const StocksMarketPage()),
          ),
        );

        var keyFinder = find.byKey(const Key('stockMarketPageUI'));

        await tester.ensureVisible(keyFinder);
        await tester.pump(const Duration(milliseconds: 10));

        expect(keyFinder, findsOneWidget);
      },
    );

    testWidgets(
        'on fetch loadStockMarketData data, and empty data is returned loadedScreen UI should not be shown',
            (WidgetTester tester) async {
          when(stockCubit.loadStockMarketData())
              .thenAnswer((_) async => NetworkResponse(true, data: []));

          await tester.pumpWidget(
            MultiBlocProvider(
              providers: [
                BlocProvider(create: (ctx) => stockCubit),
                BlocProvider(create: (ctx) => NetworkBloc()),
              ],
              child: buildTestableWidget(const StocksMarketPage()),
            ),
          );

          var keyFinder = find.byKey(const Key('loaded_stock_data'));
          await tester.pump(const Duration(milliseconds: 10));

          expect(keyFinder, findsNothing);
        });
    testWidgets(
        'on fetch loadStockMarketData data, and LoadingStockState is emitted loading state screen is displayed',
            (WidgetTester tester) async {
          when(stockCubit.state).thenReturn(LoadingStockState());
          when(stockCubit.stream)
              .thenAnswer((_) => Stream.fromIterable([LoadingStockState()]));

          await tester.pumpWidget(
            MultiBlocProvider(
              providers: [
                BlocProvider(create: (ctx) => stockCubit),
                BlocProvider(create: (ctx) => NetworkBloc()),
              ],
              child: buildTestableWidget(const StocksMarketPage()),
            ),
          );

          var keyFinder = find.byKey(const Key('loading_stock_data'));
          await tester.pump(const Duration(milliseconds: 10));

          expect(keyFinder, findsOneWidget);
        });
    testWidgets(
        'on fetch loadStockMarketData data, and SuccessStockState is emitted loading state screen is displayed',
            (WidgetTester tester) async {
          when(stockCubit.state).thenReturn(SuccessStockState(stockData: stockData));
          when(stockCubit.stream)
              .thenAnswer((_) => Stream.fromIterable([SuccessStockState(stockData: stockData)]));

          await tester.pumpWidget(
            MultiBlocProvider(
              providers: [
                BlocProvider(create: (ctx) => stockCubit),
                BlocProvider(create: (ctx) => NetworkBloc()),
              ],
              child: buildTestableWidget(const StocksMarketPage()),
            ),
          );

          var keyFinder = find.byKey(const Key('loaded_stock_data'));
          await tester.pump(const Duration(milliseconds: 10));

          expect(keyFinder, findsOneWidget);
        });
  });
}
