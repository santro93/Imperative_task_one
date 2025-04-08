import 'package:intl/intl.dart';

class AppFunctions {
  String convertDateToDDMMYYYY(String dateString) {
    final DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    DateTime dateTime = inputFormat.parse(dateString);

    final DateFormat outputFormat = DateFormat('dd-MM-yyyy');
    return outputFormat.format(dateTime);
  }

  String capitalizeFirstLetter(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }
}
