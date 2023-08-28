part of 'emp_bloc.dart';

abstract class EmpEvent extends Equatable {
  const EmpEvent();
}

class AddEmpDetailsEvent extends EmpEvent {
  final EmpModel empModel;

  const AddEmpDetailsEvent(this.empModel);

  @override
  List<Object> get props => [empModel];
}

class UpdateEmpDetailsEvent extends EmpEvent {
  final EmpModel empModel;

  const UpdateEmpDetailsEvent(this.empModel);

  @override
  List<Object> get props => [empModel];
}

class GetEmpDetailsListEvent extends EmpEvent {
  const GetEmpDetailsListEvent();

  @override
  List<Object> get props => [];
}

class DeleteEmpDetailsEvent extends EmpEvent {
  final EmpModel empModel;

  const DeleteEmpDetailsEvent(this.empModel);

  @override
  List<Object> get props => [empModel];
}
