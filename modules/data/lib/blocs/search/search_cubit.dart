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
      Fimber.i(
          "searchedQuery is $searchedQuery and ${searchedQuery.isNotEmpty}");
      var filteredStockData = await _stockDao.filterStockDataBySearch(searchedQuery);
      filteredStock = dtoMapper.mapFromDtoListToDomain(filteredStockData);
      if (filteredStock.isNotEmpty) {
        emit(SuccessSearchState(stockData: filteredStock));
      } else {
        if (searchedQuery.isNotEmpty) {
          emit(LoadingSearchState());
        } else {
          emit(EmptySearchState());
        }
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
