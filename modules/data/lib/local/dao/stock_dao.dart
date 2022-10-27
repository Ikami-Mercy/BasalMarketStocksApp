import 'package:data/dtos/stock_data_dto.dart';
import 'package:floor/floor.dart';


@dao
abstract class StockDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> saveAdvertItems(List<StockDataDto> dto);

  @Query('SELECT * FROM StockDataDto')
  Future<List<StockDataDto>> getAdvertItems();
}