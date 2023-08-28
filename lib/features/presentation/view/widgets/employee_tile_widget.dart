import 'package:employee_management/domain/emp_model.dart';
import 'package:employee_management/features/presentation/bloc/emp_bloc.dart';
import 'package:employee_management/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class EmployeeTileWidget extends StatelessWidget {
  final EmpModel empModel;
  const EmployeeTileWidget({
    super.key,
    required this.empModel,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(empModel.empId!.toString()),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: () {}),
        extentRatio: 0.2,
        dragDismissible: false,
        children: [
          CustomSlidableAction(
            backgroundColor: Colors.red,
            onPressed: (BuildContext context) {
              BlocProvider.of<EmpBloc>(context).add(DeleteEmpDetailsEvent(empModel));
            },
            autoClose: true,
            child: SvgPicture.asset("assets/icons/delete_ic.svg"),
          ),
        ],
      ),
      child: InkWell(
        onTap: () async {
          final res = await context.push("/addEmpDetails", extra: empModel);
          if (res != null && res == "true") {
            BlocProvider.of<EmpBloc>(context).add(const GetEmpDetailsListEvent());
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.h),
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  empModel.empName!,
                  style: TextStyle(
                      fontSize: 16.sp, color: inputTextColor, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  child: Text(
                    empModel.empRole!,
                    style: TextStyle(fontSize: 14.sp, color: hintColor),
                  ),
                ),
                Text(
                  (((empModel.endDate != null) && (empModel.endDate!.isNotEmpty)) ? "" : "From ") +
                      empModel.startDate! +
                      (((empModel.endDate != null) && (empModel.endDate!.isNotEmpty))
                          ? " - ${empModel.endDate!}"
                          : ""),
                  style: TextStyle(fontSize: 12.sp, color: hintColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
