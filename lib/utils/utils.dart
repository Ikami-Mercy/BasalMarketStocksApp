import 'package:data/blocs/stocks/stock_cubit.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

String startDate = '';
String endDate = '';

void showDateRangeDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text(
              'SELECT RANGE',
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            content: SizedBox(
              height: 250,
              width: 300,
              child: Column(
                children: <Widget>[
                  getDateRangePicker(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MaterialButton(
                        child: const Text("CANCEL"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      MaterialButton(
                        child: const Text("OK"),
                        onPressed: () {
                          //PASS SELECTED DATES HERE
                          context.read<StockCubit>().filterStockDataByDate(startDate, endDate);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ));
      });
}

Widget getDateRangePicker() {
  DateTime now = DateTime.now();
  return SizedBox(
    height: 200,
    width: 300,
    child: SfDateRangePicker(
      view: DateRangePickerView.month,
      selectionMode: DateRangePickerSelectionMode.range,
      onSelectionChanged: _onSelectionChanged,
      maxDate: DateTime(
        now.year,
        now.month,
        now.day,
      ),
    ),
  );
}

void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
  Fimber.i("Selected date range is ${args.value}");
  if (args.value.startDate != null) {
    startDate = DateFormat('yyyy-MM-dd HH:mm:ss')
        .format(args.value.startDate);
    Fimber.i("SELECTED START DATE IS $startDate");

  }
  if (args.value.endDate != null) {
    endDate = DateFormat('yyyy-MM-dd HH:mm:ss')
        .format(args.value.endDate);
  }

}
