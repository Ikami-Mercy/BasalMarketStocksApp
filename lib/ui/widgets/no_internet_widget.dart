import 'package:basal_test/utils/resources/strings.dart';
import 'package:data/blocs/internet/network_bloc.dart';
import 'package:data/blocs/internet/network_state.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import '../../utils/resources/colors.dart';

class NoInternetWidget extends StatefulWidget {
  const NoInternetWidget({Key? key}) : super(key: key);

  @override
  State<NoInternetWidget> createState() => _NoInternetWidgetState();
}

class _NoInternetWidgetState extends State<NoInternetWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkBloc, NetworkState>(
        buildWhen: (prevState, currentState) {
      return currentState is NetworkFailure || currentState is NetworkSuccess;
    }, builder: (ctx, state) {
      if (state is NetworkFailure) {
        return Center(
          child: Text(
            AppStrings.deviceOffline,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: AppColors.dangerBackground,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      } else if (state is NetworkSuccess) {
        return const Center(
          child: Text(
            AppStrings.deviceOnline,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.lightBlueAccent,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
