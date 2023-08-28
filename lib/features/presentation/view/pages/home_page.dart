import 'package:employee_management/features/presentation/bloc/emp_bloc.dart';
import 'package:employee_management/features/presentation/view/pages/subpages/home_page_subpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmpBloc(),
      child: const HomePageSubpage(),
    );
  }

}
