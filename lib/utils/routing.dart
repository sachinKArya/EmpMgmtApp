import 'package:employee_management/domain/emp_model.dart';
import 'package:employee_management/features/presentation/view/pages/add_update_employee_details_page.dart';
import 'package:employee_management/features/presentation/view/pages/home_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(path: "/", builder: (context, state) => const HomePage()),
  GoRoute(
      path: "/addEmpDetails",
      builder: (context, state) => AddUpdateEmployeeDetailsPage(
            empModel: state.extra as EmpModel?,
          )),
]);
