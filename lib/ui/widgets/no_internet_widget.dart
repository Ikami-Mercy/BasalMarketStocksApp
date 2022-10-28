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
        return Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.dangerBackground,
                border: Border.all(
                  color: AppColors.borderColor,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
                child: Text(
                  AppStrings.deviceOffline,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        );
      } else if (state is NetworkSuccess) {
        return const SizedBox.shrink();
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
