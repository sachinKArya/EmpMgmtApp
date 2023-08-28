import 'package:employee_management/domain/emp_model.dart';
import 'package:employee_management/features/presentation/bloc/emp_bloc.dart';
import 'package:employee_management/features/presentation/view/pages/subpages/add_update_employee_details_subpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUpdateEmployeeDetailsPage extends StatelessWidget {
  final EmpModel? empModel;
  const AddUpdateEmployeeDetailsPage({Key? key, this.empModel }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmpBloc(),
      child: AddUpdateEmployeeDetailsSubpage(empModel: empModel),
    );
  }
}
