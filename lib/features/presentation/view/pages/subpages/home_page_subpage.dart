import 'package:employee_management/features/presentation/view/widgets/custom_app_bar.dart';
import 'package:employee_management/features/presentation/bloc/emp_bloc.dart';
import 'package:employee_management/features/presentation/view/widgets/employee_tile_widget.dart';
import 'package:employee_management/utils/app_util_methods.dart';
import 'package:employee_management/utils/colors.dart';
import 'package:employee_management/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class HomePageSubpage extends StatefulWidget {
  const HomePageSubpage({Key? key}) : super(key: key);

  @override
  State<HomePageSubpage> createState() => _HomePageSubpageState();
}

class _HomePageSubpageState extends State<HomePageSubpage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<EmpBloc>(context).add(const GetEmpDetailsListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(title: employeeList),
        body: BlocConsumer<EmpBloc, EmpState>(
          listener: (context, state) {
            debugPrint(state.toString());
            if (state is GetEmpListError) {
              //Display Snack-bar here
            } else if (state is GetEmpListLoaded) {
              debugPrint("state is GetEmpListLoaded: ${state.list}");
            } else if (state is DeleteEmpLoaded ||
                state is UpdateEmpLoaded ||
                state is CreateEmpLoaded) {
              BlocProvider.of<EmpBloc>(context).add(const GetEmpDetailsListEvent());
            }
            if (state is DeleteEmpLoaded) {
              AppUtilMethods().showSnackbar(context, employeeDataDeleted,
                  action: SnackBarAction(
                    label: undo,
                    textColor: themeColor,
                    onPressed: () {
                      BlocProvider.of<EmpBloc>(context).add(AddEmpDetailsEvent(state.empModel));
                    },
                  ));
            }
          },
          builder: (context, state) {
            if (state is GetEmpListLoaded) {
              List<Widget> curEmpList = [getHeader(curEmp)];
              List<Widget> prevEmpList = [getHeader(prevEmp)];
              List<Widget> list = [];
              for (int i = 0; i < state.list.length; i++) {
                Widget widget = EmployeeTileWidget(empModel: state.list[i]);
                if ((state.list[i].endDate != null) && (state.list[i].endDate!.isNotEmpty)) {
                  prevEmpList.add(widget);
                } else {
                  curEmpList.add(widget);
                }
              }
              if (curEmpList.length > 1) {
                list.addAll(curEmpList);
              }
              if (prevEmpList.length > 1) {
                list.addAll(prevEmpList);
              }
              return ListView.separated(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return list[index];
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    color: dividerColor,
                    height: 1,
                  );
                },
              );
            } else if (state is GetEmpListEmpty) {
              return Container(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/img_no_data.svg',
                    height: 244.h,
                    width: 261.w,
                  ),
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                strokeWidth: 4.0,
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final res = await context.push("/addEmpDetails");
            if (res != null && res == "true") {
              BlocProvider.of<EmpBloc>(context).add(const GetEmpDetailsListEvent());
            }
          },
          backgroundColor: themeColor,
          shape:
              const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget getHeader(String name) {
    return Container(
      color: dividerColor,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Text(
        name,
        style: TextStyle(color: themeColor, fontSize: 16.sp),
      ),
    );
  }
}
