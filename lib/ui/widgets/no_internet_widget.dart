import 'package:basal_test/utils/resources/strings.dart';
import 'package:flutter/material.dart';

import '../../utils/resources/colors.dart';

class NoInternetWidget extends StatelessWidget {
  final bool connectedToInternet;

  const NoInternetWidget({Key? key, required this.connectedToInternet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Visibility(
      visible: connectedToInternet,
      child: Center(
        child: Text(
          AppStrings.deviceOffline,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: AppColors.dangerBackground,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
