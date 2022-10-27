import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import '../../utils/resources/assets.dart';
import '../../utils/resources/colors.dart';

class ErrorStatePage extends StatefulWidget {
  final Function? errorStateAction;

  const ErrorStatePage({Key? key, this.errorStateAction}) : super(key: key);

  @override
  _ErrorStatePageState createState() => _ErrorStatePageState();
}

class _ErrorStatePageState extends State<ErrorStatePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(100.0),
              child: SvgPicture.asset(Assets.errorIcon),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  children: [
                    const Text.rich(
                      TextSpan(
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        text: 'Ooops',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                          color: AppColors.colorGray7,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                        text: 'An error occurred',
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.white,
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.lightBlue,
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: const BorderSide(
                              color: Colors.lightBlue,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () => {
                        if (widget.errorStateAction != null)
                          {
                            widget.errorStateAction!(),
                          },
                      },
                      child: const Text(
                        'Please try again',
                        style: TextStyle(fontSize: 14),
                      ),
                      // Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
