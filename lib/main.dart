import 'package:basal_test/ui/screens/stocks_market_page.dart';
import 'package:data/blocs/simple_bloc_observer.dart';
import 'package:data/blocs/stocks/stock_cubit.dart';
import 'package:data/blocs/stocks/stock_state.dart';
import 'package:data/di/injection.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import 'init_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  InitServices().initLogger();
  await InitServices().initEnv(true);


  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<StockCubit>()),
      ],
      child: MaterialApp(
        title: 'BasaltMarketStock App ',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocBuilder<StockCubit, StockState>(builder: (ctx, state) {
          return const StocksMarketPage();
        }),
      ),
    );
  }
}
