import 'dart:async';

import 'package:dependencies/dependencies.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../dtos/stock_data_dto.dart';
import 'dao/stock_dao.dart';

part 'app_database.g.dart';

@Database(
    version: 1, entities: [StockDataDto])
abstract class AppDatabase extends FloorDatabase {
  StockDao get stockDao;
}

void runDbQueries(List<Future<void>> queries) async {
  for (var query in queries) {
    try {
      await query;
    } catch (e) {
      Fimber.e("Error running query [$query]: $e", ex: e);
    }
  }
}
