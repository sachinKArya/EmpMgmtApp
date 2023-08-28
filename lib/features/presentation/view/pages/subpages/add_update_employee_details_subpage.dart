import 'package:employee_management/domain/emp_model.dart';
import 'package:employee_management/features/presentation/view/widgets/custom_app_bar.dart';
import 'package:employee_management/features/presentation/bloc/emp_bloc.dart';
import 'package:employee_management/features/presentation/view/helper_methods/employee_helper_methods.dart';
import 'package:employee_management/features/presentation/view/widgets/custom_elevated_button.dart';
import 'package:employee_management/features/presentation/view/widgets/custom_text_box.dart';
import 'package:employee_management/features/presentation/view/widgets/overlay_loading_widget.dart';
import 'package:employee_management/utils/app_util_methods.dart';
import 'package:employee_management/utils/colors.dart';
import 'package:employee_management/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AddUpdateEmployeeDetailsSubpage extends StatefulWidget {
  final EmpModel? empModel;
  const AddUpdateEmployeeDetailsSubpage({Key? key, this.empModel}) : super(key: key);

  @override
  State<AddUpdateEmployeeDetailsSubpage> createState() => _AddUpdateEmployeeDetailsSubpageState();
}

class _AddUpdateEmployeeDetailsSubpageState extends State<AddUpdateEmployeeDetailsSubpage> with EmployeeHelper {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.empModel != null) {
      nameController.text = widget.empModel!.empName!;
      roleController.text = widget.empModel!.empRole!;
      startDateController.text = widget.empModel!.startDate!;
      endDateController.text = widget.empModel!.endDate ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmpBloc, EmpState>(
      listener: (context, state) {
        if (state is EmpInitial || state is CreateEmpLoading || state is UpdateEmpLoading) {
          OverlayLoadingWidget().showLoader(context);
        } else {
          OverlayLoadingWidget().hideLoader();
          if (state is CreateEmpLoaded || state is UpdateEmpLoaded) {
            context.pop("true");
          } else if (state is CreateEmpError || state is UpdateEmpError) {
            //Display Snack-bar
            AppUtilMethods().showSnackbar(context, errorWhileRequesting);
          }
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: const CustomAppBar(title: addEmployeeDetails),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 24.h),
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: nameController,
                      hintName: employeeName,
                      prefixIconName: "user_ic.svg",
                    ),
                    SizedBox(height: 23.h),
                    CustomTextFormField(
                      controller: roleController,
                      hintName: selectRole,
                      prefixIconName: "work_profile_ic.svg",
                      suffixWidget: SvgPicture.asset(
                        'assets/icons/arrow_drop_down_ic.svg',
                      ),
                      readOnly: true,
                      onTap: () {
                        showEmployeeRoleBottomSheet(context, roleController, onPressed: () {
                          context.pop();
                        });
                      },
                    ),
                    SizedBox(height: 23.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 174.w,
                          child: CustomTextFormField(
                            controller: startDateController,
                            hintName: today,
                            prefixIconName: "calendar_ic.svg",
                            readOnly: true,
                            onTap: () {
                              showCustomDatePicker(context, startDateController, "StartDate");
                            },
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/icons/arrow_right_ic.svg',
                          width: 20.w,
                          height: 20.h,
                        ),
                        SizedBox(
                          width: 174.w,
                          child: CustomTextFormField(
                            controller: endDateController,
                            hintName: noDate,
                            prefixIconName: "calendar_ic.svg",
                            readOnly: true,
                            onTap: () {
                              showCustomDatePicker(context, endDateController, "EndDate");
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Divider(thickness: 2.sp, color: dividerColor),
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 12.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomElevatedButton(
                          buttonText: cancel,
                          backgroundColor: lightBlueColor,
                          textColor: themeColor,
                          minimumSize: Size(73.w, 40.h),
                          radius: 6.r,
                          onPressed: () {
                            context.pop();
                          },
                        ),
                        SizedBox(width: 16.w),
                        CustomElevatedButton(
                          buttonText: save,
                          backgroundColor: themeColor,
                          textColor: Colors.white,
                          minimumSize: Size(73.w, 40.h),
                          radius: 6.r,
                          onPressed: () {
                            if (nameController.text.isNotEmpty &&
                                roleController.text.isNotEmpty &&
                                startDateController.text.isNotEmpty) {
                              EmpModel empModel = EmpModel(
                                  empName: nameController.text,
                                  empRole: roleController.text,
                                  startDate: startDateController.text,
                                  endDate: endDateController.text,
                                  empId: widget.empModel?.empId,
                              );

                              if (widget.empModel != null) {
                                BlocProvider.of<EmpBloc>(context)
                                    .add(UpdateEmpDetailsEvent(empModel));
                              } else {
                                BlocProvider.of<EmpBloc>(context).add(AddEmpDetailsEvent(empModel));
                              }
                              debugPrint(
                                  "empModel: ${empModel.empName}, ${empModel.empRole}, ${empModel.startDate}, ${empModel.endDate}");
                            } else {
                              AppUtilMethods().showSnackbar(context, fillRequiredInfo);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
