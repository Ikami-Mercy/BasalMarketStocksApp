import 'package:data/dtos/stock_data_dto.dart';
import 'package:floor/floor.dart';

@dao
abstract class StockDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> saveAdvertItems(List<StockDataDto> dto);

  @Query('SELECT * FROM StockDataDto')
  Future<List<StockDataDto>> getStockData();

  @Query('DELETE FROM StockDataDto')
  Future<void> deleteStockData();

  @Query('SELECT * FROM StockDataDto WHERE date BETWEEN :startDate AND :endDate')
  Future<List<StockDataDto>> filterStockDataByDate(String startDate,String endDate );

  @Query('SELECT * FROM StockDataDto WHERE symbol LIKE :searchedQuery')
  Future<List<StockDataDto>> filterStockDataBySearch(String searchedQuery);
}
