import 'package:basal_test/ui/widgets/stock_item_widget.dart';
import 'package:domain/models/stock_data.dart';
import 'package:flutter/material.dart';

class StocksWidget extends StatefulWidget {
  final List<StockData> stockList;
  const StocksWidget({Key? key, required this.stockList}) : super(key: key);

  @override
  State<StocksWidget> createState() => _StocksWidgetState();
}

class _StocksWidgetState extends State<StocksWidget> {
  late List<Widget> stockWidget;

  @override
  void initState() {
    stockWidget = widget.stockList
        .map((e) => StockItemWidget(stock: e),
    ).toList();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      key: const Key('MarketStockUI'),
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: stockWidget,
          ),
        ),
      ],
    );
  }
}
