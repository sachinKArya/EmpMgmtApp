class EmpModel {
  int? empId;
  String? empName;
  String? empRole;
  String? startDate;
  String? endDate;

  EmpModel({
    this.empId,
    this.empName,
    this.empRole,
    this.startDate,
    this.endDate,
  });

  EmpModel.fromMap(Map json)
      : this(
          empId: json['empId'],
          empName: json['empName'],
          empRole: json['empRole'],
          startDate: json['startDate'],
          endDate: json['endDate'],
        );

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['empId'] = empId;
    data['empName'] = empName;
    data['empRole'] = empRole;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    return data;
  }
}
