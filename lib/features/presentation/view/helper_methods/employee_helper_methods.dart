import 'package:employee_management/utils/app_util_methods.dart';
import 'package:employee_management/utils/colors.dart';
import 'package:employee_management/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:employee_management/features/presentation/view/widgets/custom_date_picker.dart' as custom;
import 'package:go_router/go_router.dart';

mixin EmployeeHelper {
  void showEmployeeRoleBottomSheet(BuildContext context, TextEditingController roleController,
      {required Function() onPressed}) {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      backgroundColor: Colors.white,
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.85),
      builder: (BuildContext context) {
        return ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: roleList.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext ct, int index) {
            return InkWell(
              onTap: () {
                roleController.text = roleList[index];
                context.pop();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Center(
                  child: Text(
                    roleList[index],
                    style: TextStyle(color: inputTextColor, fontSize: 16.sp),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        );
      },
    );
  }

  Future<void> showCustomDatePicker(
      BuildContext context, TextEditingController textController, String fieldName) async {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.all(16.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          child: Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: themeColor,
                onPrimary: Colors.white,
                onSurface: inputTextColor,
              ),
            ),
            child: Container(
              constraints: BoxConstraints(maxHeight: 500.h),
              child: custom.CalendarDatePicker(
                onDateChanged: (dateTime) {
                  debugPrint("New DateTime: $dateTime");
                },
                fieldName: fieldName,
                initialDate: fieldName == "StartDate" ? (textController.text.isNotEmpty
                    ? AppUtilMethods.parseDate(textController.text, "dd MMM yyyy")
                    : DateTime.now()) : null,
                firstDate: DateTime(1950),
                lastDate: DateTime(2050),
                textController: textController,
              ),
            ),
          ),
        );
      },
    );
  }
}
