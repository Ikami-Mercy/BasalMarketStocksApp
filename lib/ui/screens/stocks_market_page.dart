import 'package:data/blocs/stocks/stock_cubit.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

class StocksMarketPage extends StatefulWidget {
  const StocksMarketPage({Key? key}) : super(key: key);

  @override
  State<StocksMarketPage> createState() => _StocksMarketPageState();
}

class _StocksMarketPageState extends State<StocksMarketPage> {

  void _incrementCounter() {

    context.read<StockCubit>().loadStockMarketData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
    ));
  }
}
