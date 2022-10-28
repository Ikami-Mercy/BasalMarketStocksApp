import 'package:data/local/dao/stock_dao.dart';
import 'package:data/network/api_service.dart';
import 'package:data/repositories/stocks_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([ApiService,StockDao])
void main(){
  group('Stocks Repository', () {
    late ApiService apiService;
    late StockRepository stockRepository;


    setUp(() {

}
        }