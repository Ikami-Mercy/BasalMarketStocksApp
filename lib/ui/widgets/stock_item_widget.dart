import 'package:basal_test/utils/resources/strings.dart';
import 'package:domain/models/stock_data.dart';
import 'package:flutter/material.dart';

import '../../utils/resources/colors.dart';

class StockItemWidget extends StatelessWidget {
  final StockData stock;

  const StockItemWidget({Key? key, required this.stock}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
      children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Symbol',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: AppColors.textColorGray,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4,),
                  Text(
                    stock.symbol ?? '',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: AppColors.textColorNormal,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.exchange,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: AppColors.textColorGray,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4,),
                  Text(
                    stock.exchange ?? '',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: AppColors.textColorNormal,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 1,
              width: double.infinity,
              child: Divider(
                color: AppColors.borderColor,
                thickness: 1,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${AppStrings.open} ${stock.open}',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: AppColors.textColorGray,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4,),
                  Text(
                    '${AppStrings.low} ${stock.low}',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: AppColors.textColorGray,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: SizedBox(
                  height: 40,
                  child: VerticalDivider(
                    color: AppColors.borderColor,
                    thickness: 1,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${AppStrings.close} ${stock.close}',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: AppColors.textColorGray,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4,),
                  Text(
                    '${AppStrings.high} ${stock.high}',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: AppColors.textColorGray,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
            ],
          ),
      ],
    ),
        ));
  }
}
