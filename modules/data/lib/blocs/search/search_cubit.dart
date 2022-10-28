import 'package:data/blocs/search/search_state.dart';
import 'package:data/local/dao/stock_dao.dart';
import 'package:data/mappers/stock_data_dto_mapper.dart';
import 'package:dependencies/dependencies.dart';
import 'package:domain/models/stock_data.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  final StockDao stockDao;
  List<StockData> locallySavedStocks = [];
  List<StockData> filteredStock = [];
  StockDataDtoMapper dtoMapper = StockDataDtoMapper();

  SearchCubit(this.stockDao) : super(InitialSearchState());

  void filterStockDataBySearch(String searchedQuery) async {
    try {
      var filteredStockData =
          await stockDao.filterStockDataBySearch('%$searchedQuery%');
      filteredStock = dtoMapper.mapFromDtoListToDomain(filteredStockData);
      if (filteredStock.isNotEmpty) {
        emit(SuccessSearchState(stockData: filteredStock));
      } else {
        emit(EmptySearchState());
      }
    } catch (e) {
      Fimber.e("Error searching Stock Data: $e", ex: e);
        emit(ErrorSearchState());

    }
  }

  void resetSearchQuery() {
    emit(InitialSearchState());
  }
}
