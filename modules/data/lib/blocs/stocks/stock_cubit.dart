import 'package:data/blocs/stocks/stock_state.dart';
import 'package:data/local/dao/stock_dao.dart';
import 'package:data/mappers/stock_data_dto_mapper.dart';
import 'package:data/utils/constants.dart';
import 'package:dependencies/dependencies.dart';
import 'package:domain/models/stock_data.dart';
import 'package:domain/repositories/stocks_repository.dart';

@injectable
class StockCubit extends Cubit<StockState> {
  final IStockRepository _stockRepository;
  final StockDao _stockDao;
  List<StockData> locallySavedStocks = [];
  List<StockData> filteredStock = [];
  StockDataDtoMapper dtoMapper = StockDataDtoMapper();
  String key = dotenv.env['MARKET_STACK_API_KEY'] ?? 'testKey';

  StockCubit(this._stockRepository, this._stockDao)
      : super(InitialStockState());

  void loadStockMarketData() async {
    loadLocalStockMarketData();
    try {
      var response = await _stockRepository.fetchStockMarketData(key,
          Constants.PAGINATION_PAGE_SIZE, Constants.stockMarketSymbolsArray);
      if (response.success) {
        Fimber.i(
            'SuccessStockState emitted and page count is: ${response.extras}');
        emit(SuccessStockState(stockData: response.data!));
      }
    } catch (e) {
      Fimber.e("Error fetching Stock Market Data: $e", ex: e);
      if (locallySavedStocks.isEmpty) {
        emit(ErrorStockState());
      }
    }
  }

  void loadLocalStockMarketData() async {
    emit(LoadingStockState());
    var savedStockMarketData = await _stockDao.getStockData();
    locallySavedStocks = dtoMapper.mapFromDtoListToDomain(savedStockMarketData);
    if (locallySavedStocks.isNotEmpty) {
      emit(SuccessStockState(stockData: locallySavedStocks));
    }
  }
}
