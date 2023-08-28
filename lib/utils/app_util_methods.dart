import 'package:employee_management/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  DateTime next(int day) {
    return add(
      Duration(
        days: (day - weekday) % DateTime.daysPerWeek,
      ),
    );
  }
}

class AppUtilMethods {
  static String convert(String stringDate,
      {String? outputFormat,
      String? inputFormat,
      bool ignoreLocaleForOutput = false,
      bool utcToLocale = false}) {
    if (stringDate.isNotEmpty && stringDate != "null") {
      outputFormat ??= "dd MMM yy";
      /*if(stringDate.contains("."))
        {
          stringDate=stringDate.split(".")[0];
        }*/

      DateTime dt = parseDate(stringDate, inputFormat, isUtc: utcToLocale);
      final newFormat = DateFormat(outputFormat, "en_US");
      if (utcToLocale) {
        dt = dt.toLocal();
      }
      final String updatedDt = newFormat.format(dt);
      return updatedDt;
    }
    return "";
  }

  static DateTime parseDate(String stringDate, String? inputFormat,
      {bool ignoreLocaleForOutput = false, bool isUtc = false}) {
    if (inputFormat != null) {
      String locale = "en_US";
      final DateFormat dateFormat = DateFormat(inputFormat, locale);
      return dateFormat.parse(stringDate, isUtc);
    } else {
      return DateTime.parse(
        stringDate,
      );
    }
  }

  void showSnackbar(BuildContext context, String msg, {SnackBarAction? action}) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg, style: TextStyle(color: Colors.white, fontSize: 15.sp)),
      backgroundColor: inputTextColor,
      action: action,
    ));
  }
}
