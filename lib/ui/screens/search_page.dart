import 'package:basal_test/utils/resources/strings.dart';
import 'package:data/blocs/search/search_cubit.dart';
import 'package:data/blocs/search/search_state.dart';
import 'package:dependencies/dependencies.dart';
import 'package:domain/models/stock_data.dart';
import 'package:flutter/material.dart';

import '../widgets/stock_item_widget.dart';
import 'error_state_page.dart';

class SearchPage extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          context.read<SearchCubit>().resetSearchQuery();
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<SearchCubit>().resetSearchQuery();
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    context.read<SearchCubit>().filterStockDataBySearch(query.toUpperCase());
    return resultsWidget();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    context.read<SearchCubit>().filterStockDataBySearch(query.toUpperCase());
    return resultsWidget();
  }

  Widget resultsWidget() {
    List<StockData> stockList = [];
    return SafeArea(
        child: BlocConsumer<SearchCubit, SearchState>(
      listener: (ctx, state) {
        if (state is SuccessSearchState) {
          state.stockData.map((element) {
            stockList.add(element);
          }).toList();
        }
      },
      builder: (ctx, state) {
        if (state is LoadingSearchState) {
          return const Center(
            child: CircularProgressIndicator(
              key: Key('loading_search_data'),
            ),
          );
        }
        if (state is SuccessSearchState) {
          return ListView.builder(
            key: const Key('loaded_search_data'),
            itemCount: stockList.length,
            itemBuilder: (context, index) {
              var result = stockList[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: StockItemWidget(stock: result),
              );
            },
          );
        }
        if (state is EmptySearchState) {
          return const ErrorStatePage(
            message: AppStrings.symbolNotFound,
          );
        } else {
          return const ErrorStatePage(
            message: AppStrings.searchForSymbol,
          );
        }
      },
    ));
  }
}
