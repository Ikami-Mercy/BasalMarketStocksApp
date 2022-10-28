import 'package:data/blocs/search/search_state.dart';
import 'package:data/local/dao/stock_dao.dart';
import 'package:data/mappers/stock_data_dto_mapper.dart';
import 'package:dependencies/dependencies.dart';
import 'package:domain/models/stock_data.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  final StockDao _stockDao;
  List<StockData> locallySavedStocks = [];
  List<StockData> filteredStock = [];
  StockDataDtoMapper dtoMapper = StockDataDtoMapper();

  SearchCubit(this._stockDao) : super(InitialSearchState());

  void filterStockDataBySearch(String searchedQuery) async {
    try {
      //var filteredStockData = await _stockDao.filterStockDataBySearch(searchedQuery);
      Fimber.i('Filtered results is $searchedQuery');
      var queryToSearch = searchedQuery.isEmpty?searchedQuery:'%$searchedQuery%';
      var filteredStockData = await _stockDao.filterStockDataBySearch('%$searchedQuery%');
      filteredStock = dtoMapper.mapFromDtoListToDomain(filteredStockData);
      Fimber.i('filteredStock is ${filteredStock.length}');
      if (filteredStock.isNotEmpty) {
        emit(SuccessSearchState(stockData: filteredStock));
      } else {
        emit(EmptySearchState());
      }
    } catch (e) {
      Fimber.e("Error searching Stock Data: $e", ex: e);
      if (locallySavedStocks.isEmpty) {
        emit(ErrorSearchState());
      }
    }
  }

  void resetSearchQuery() {
    emit(EmptySearchState());
  }
}
