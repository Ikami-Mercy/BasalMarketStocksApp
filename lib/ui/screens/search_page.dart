import 'package:basal_test/utils/resources/strings.dart';
import 'package:data/blocs/search/search_cubit.dart';
import 'package:data/blocs/search/search_state.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import '../widgets/stocks_widget.dart';
import 'error_state_page.dart';

class SearchPage extends SearchDelegate {
// first overwrite to
// clear the search text
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

// second overwrite to pop out of search menu
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

// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    context.read<SearchCubit>().filterStockDataBySearch(query.toUpperCase());

    return resultsWidget();
  }

// last overwrite to show the
// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    context.read<SearchCubit>().filterStockDataBySearch(query.toUpperCase());

    return resultsWidget();
  }

  Widget resultsWidget() {
    return SafeArea(
        child: BlocBuilder<SearchCubit, SearchState>(
      buildWhen: (prevState, currentState) {
        return currentState is LoadingSearchState ||
            currentState is SuccessSearchState ||
            currentState is EmptySearchState ||
            currentState is ErrorSearchState;
      },
      builder: (ctx, state) {
        if (state is LoadingSearchState) {
          return const Center(
            child: CircularProgressIndicator(
              key: Key('loading_stock_data'),
            ),
          );
        }
        if (state is SuccessSearchState) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            key: const Key('loaded_stock_data'),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StocksWidget(
                    stockList: state.stockData,
                  )
                ],
              ),
            ),
          );
        }
        if (state is ErrorSearchState){
          return const ErrorStatePage( message: AppStrings.symbolNotFound,isConnectedToInternet: false,);
        }
        else {
          return const ErrorStatePage(message:AppStrings.searchForSymbol,isConnectedToInternet: false,);
        }
      },
    ));
  }
}
