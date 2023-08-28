import 'package:employee_management/data/emp_local_datasource.dart';
import 'package:employee_management/domain/emp_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'emp_event.dart';
part 'emp_state.dart';

class EmpBloc extends Bloc<EmpEvent, EmpState> {
  EmpBloc() : super(EmpInitial()) {
    on<EmpEvent>(
      (event, emit) async {
        if (event is AddEmpDetailsEvent) {
          //Call Repository class for creating the employee details..
          emit(CreateEmpLoading());
          final EmpLocalRepository repos = EmpLocalRepository();
          final response = await repos.addEmployee(event.empModel);
          if (response != null) {
            emit(CreateEmpLoaded());
          } else {
            emit(CreateEmpError());
          }
        } else if (event is UpdateEmpDetailsEvent) {
          emit(UpdateEmpLoading());
          final EmpLocalRepository repos = EmpLocalRepository();
          final response = await repos.updateEmployee(event.empModel);
          if (response != null) {
            emit(UpdateEmpLoaded());
          } else {
            emit(UpdateEmpError());
          }
        } else if (event is GetEmpDetailsListEvent) {
          emit(GetEmpListLoading());
          final EmpLocalRepository repos = EmpLocalRepository();
          final response = await repos.getEmployeeList();
          if (response != null) {
            if (response.isEmpty) {
              emit(const GetEmpListEmpty());
            } else {
              emit(GetEmpListLoaded(response));
            }
          } else {
            emit(GetEmpListError());
          }
        } else if (event is DeleteEmpDetailsEvent) {
          emit(DeleteEmpLoading());
          final EmpLocalRepository repos = EmpLocalRepository();
          final response = await repos.deleteEmployee(event.empModel.empId!);
          if (response != null) {
            emit(DeleteEmpLoaded(event.empModel));
          } else {
            emit(DeleteEmpError());
          }
        }
      },
    );
  }
}
