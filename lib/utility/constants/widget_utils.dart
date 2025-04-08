import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

Widget verticalSpaceTiny = const SizedBox(height: 5);
Widget verticalSpaceSmall = const SizedBox(height: 10);
Widget verticalSpaceMedium = const SizedBox(height: 15);
Widget verticalSpaceNormal = const SizedBox(height: 20);
Widget verticalSpaceLarge = const SizedBox(height: 30);
Widget horizontalSpaceTiny = const SizedBox(width: 5);
Widget horizontalSpaceSmall = const SizedBox(width: 10);
Widget horizontalSpaceMedium = const SizedBox(width: 15);
Widget horizontalSpaceNormal = const SizedBox(width: 20);
Widget horizontalSpaceLarge = const SizedBox(width: 30);

Widget verticalSpace(double? height, {required Widget child}) =>
    SizedBox(height: height, child: child);

Widget horizontalSpace(double? width, {required Widget child}) =>
    SizedBox(width: width, child: child);

Widget verticalFullSpace({required Widget child}) =>
    SizedBox(height: double.infinity, child: child);

Widget horizontalFullSpace({required Widget child}) =>
    SizedBox(width: double.infinity, child: child);

Container buildLineSeperationWidget(
    {double? padvalue, required BuildContext context}) {
  return Container(
    height: padvalue,
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          width: 0.7,
          color: Theme.of(context).dividerColor,
        ),
      ),
    ),
  );
}

Widget buildDivider(BuildContext context) {
  return Divider(color: Theme.of(context).dividerColor);
}

Future success(context,
    {String? title,
    String? message,
    Duration duration = const Duration(seconds: 3)}) {
  final Flushbar flushbar = Flushbar(
    title: title,
    message: message,
    flushbarStyle: FlushbarStyle.GROUNDED,
    icon: Icon(
      Icons.check_circle_outline,
      size: 28,
      color: Colors.greenAccent[700],
    ),
    duration: duration,
    leftBarIndicatorColor: Colors.greenAccent[700],
  );
  return flushbar.show(context);
}

Future warning(context,
    {String? title,
    String? message,
    Duration duration = const Duration(seconds: 3)}) {
  final Flushbar flushbar = Flushbar(
    title: title,
    message: message,
    flushbarStyle: FlushbarStyle.GROUNDED,
    icon: Icon(
      Icons.warning,
      size: 28.0,
      color: Colors.yellowAccent[700],
    ),
    duration: duration,
    leftBarIndicatorColor: Colors.yellowAccent[700],
  );
  return flushbar.show(context);
}

Future error(context,
    {String? title,
    String? message,
    Duration duration = const Duration(seconds: 3)}) {
  final Flushbar flushbar = Flushbar(
    title: title,
    message: message ?? '',
    flushbarStyle: FlushbarStyle.GROUNDED,
    icon: Icon(
      Icons.error_outline,
      size: 28.0,
      color: Colors.red[300],
    ),
    duration: duration,
    leftBarIndicatorColor: Colors.red[300],
  );
  return flushbar.show(context);
}

Future info(context,
    {String? title,
    String? message,
    Duration duration = const Duration(seconds: 3)}) {
  final Flushbar flushbar = Flushbar(
    title: title,
    message: message ?? '',
    flushbarStyle: FlushbarStyle.GROUNDED,
    icon: Icon(
      Icons.info_outline,
      size: 28.0,
      color: Colors.blue[300],
    ),
    duration: duration,
    leftBarIndicatorColor: Colors.blue[300],
  );
  return flushbar.show(context);
}

Flushbar loading(context, {@required String? message}) {
  final Flushbar flushbar = Flushbar(
      message: message ?? '',
      flushbarStyle: FlushbarStyle.GROUNDED,
      isDismissible: false,
      showProgressIndicator: true);
  return flushbar;
}
