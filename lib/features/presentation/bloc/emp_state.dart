part of 'emp_bloc.dart';

abstract class EmpState extends Equatable {
  const EmpState();
}

class EmpInitial extends EmpState {
  @override
  List<Object> get props => [];
}

class CreateEmpLoading extends EmpState {
  @override
  List<Object> get props => [];
}

class CreateEmpLoaded extends EmpState {
  @override
  List<Object> get props => [];
}

class CreateEmpError extends EmpState {
  @override
  List<Object> get props => [];
}

class GetEmpListLoading extends EmpState {
  @override
  List<Object> get props => [];
}

class GetEmpListLoaded extends EmpState {
  final List<EmpModel> list;
  const GetEmpListLoaded(this.list);

  @override
  List<Object> get props => [list];
}

class GetEmpListEmpty extends EmpState {
  const GetEmpListEmpty();

  @override
  List<Object> get props => [];
}

class GetEmpListError extends EmpState {
  @override
  List<Object> get props => [];
}

class DeleteEmpLoading extends EmpState {
  @override
  List<Object> get props => [];
}

class DeleteEmpLoaded extends EmpState {
  final EmpModel empModel;

  const DeleteEmpLoaded(this.empModel);
  @override
  List<Object> get props => [empModel];
}

class DeleteEmpError extends EmpState {
  @override
  List<Object> get props => [];
}

class UpdateEmpLoading extends EmpState {
  @override
  List<Object> get props => [];
}

class UpdateEmpLoaded extends EmpState {
  @override
  List<Object> get props => [];
}

class UpdateEmpError extends EmpState {
  @override
  List<Object> get props => [];
}