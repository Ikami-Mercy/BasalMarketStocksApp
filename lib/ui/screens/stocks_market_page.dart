import 'package:basal_test/ui/screens/search_page.dart';
import 'package:data/blocs/stocks/stock_cubit.dart';
import 'package:data/blocs/stocks/stock_state.dart';
import 'package:dependencies/dependencies.dart';
import 'package:domain/models/stock_data.dart';
import 'package:flutter/material.dart';

import '../../utils/resources/colors.dart';
import '../../utils/utils.dart';
import '../widgets/stocks_widget.dart';
import 'error_state_page.dart';

class StocksMarketPage extends StatefulWidget {
  const StocksMarketPage({Key? key}) : super(key: key);

  @override
  State<StocksMarketPage> createState() => _StocksMarketPageState();
}

class _StocksMarketPageState extends State<StocksMarketPage> {
  List<StockData> stocksList = [];

  @override
  void initState() {
    context.read<StockCubit>().loadStockMarketData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.colorBackground,
        appBar: AppBar(
          title: const Text(
            "Market Stock Details",
          ),
          actions: [
            IconButton(
              onPressed: () {
                // method to show the search bar
                showSearch(context: context, delegate: SearchPage());
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                showDateRangeDialog(context);
              },
              icon: const Icon(Icons.date_range_rounded),
            ),
          ],
        ),
        body: SafeArea(child: BlocBuilder<StockCubit, StockState>(
          buildWhen: (prevState, currentState) {
            return currentState is LoadingStockState ||
                currentState is SuccessStockState ||
                currentState is SuccessFilteredStockState ||
                currentState is EmptyStockFilteredState ||
                currentState is ErrorStockState;
          },
          builder: (ctx, state) {
            if (state is LoadingStockState) {
              return const Center(
                child: CircularProgressIndicator(
                  key: Key('loading_stock_data'),
                ),
              );
            }
            if (state is SuccessStockState) {
              return stockDataUILoaded(state.stockData);
            }
            if (state is SuccessFilteredStockState) {
              return stockDataUILoaded(state.stockData);
            }
            if (state is EmptyStockFilteredState) {
              return const ErrorStatePage(message: 'No data found for entered date range',);
            }
            else {
              return const ErrorStatePage(message: 'An error occurred',);
            }
          },
        )));
  }
  Widget stockDataUILoaded(List<StockData> stockList){
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      key: const Key('loaded_stock_data'),
      child: Padding(
        padding:
        const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: true,
              child: Center(
                child: Text(
                  'Device is offline',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: AppColors.dangerBackground,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            StocksWidget(
              stockList: stockList,
            )
          ],
        ),
      ),
    );
  }
}
