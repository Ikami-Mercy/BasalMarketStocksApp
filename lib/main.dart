import 'package:basal_test/ui/screens/stocks_market_page.dart';
import 'package:basal_test/utils/resources/assets.dart';
import 'package:basal_test/utils/resources/strings.dart';
import 'package:basal_test/utils/resources/styles.dart';
import 'package:data/blocs/internet/network_bloc.dart';
import 'package:data/blocs/internet/network_event.dart';
import 'package:data/blocs/search/search_cubit.dart';
import 'package:data/blocs/simple_bloc_observer.dart';
import 'package:data/blocs/stocks/stock_cubit.dart';
import 'package:data/blocs/stocks/stock_state.dart';
import 'package:data/di/injection.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';


import 'init_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Styles.setStatusBarColor();


  await InitServices().initEnv(true);
  InitServices().initLogger();

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
        BlocProvider(create: (_) => getIt<SearchCubit>()),
        BlocProvider(create: (_) => getIt<NetworkBloc>()..add(NetworkObserve())),
      ],
      child: MaterialApp(
        title: 'BasaltMarketStock App ',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Nunito',
        ),
        home: BlocBuilder<StockCubit, StockState>(builder: (ctx, state) {
          return SplashScreenView(
            navigateRoute: const StocksMarketPage(),
            duration: 3000,
            imageSize: 100,
            imageSrc:Assets.logoIcon,
            text: AppStrings.splashString,
            textStyle: const TextStyle(
              fontSize: 30.0,
              color: Colors.lightBlue
            ),
            backgroundColor: Colors.white,
          );
         // return const StocksMarketPage();
        }),
      ),
    );
  }
}
