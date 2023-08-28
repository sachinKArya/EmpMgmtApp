import 'package:employee_management/domain/emp_model.dart';
import 'package:employee_management/utils/local_db_service.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

class EmpLocalRepository {
  final SqliteService sqliteService = SqliteService();

  Future addEmployee(EmpModel empModel) async {
    try {
      final Database db = await sqliteService.initializeDB();
      final id = await db.insert(
        'emp',
        empModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      debugPrint("Insert Item ID: $id");
      return id;
    } catch (e) {
      debugPrint("addEmployee: $e");
      return null;
    }
  }

  Future<List<EmpModel>?> getEmployeeList() async {
    try {
      final db = await sqliteService.initializeDB();
      final List<Map<String, Object?>> queryResult = await db.query('emp');
      final List<EmpModel> list = queryResult.map((e) => EmpModel.fromMap(e)).toList();
      return list;
    } catch (e) {
      debugPrint("addEmployee: $e");
      return null;
    }
  }

  Future updateEmployee(EmpModel empModel) async {
    try {
      final Database db = await sqliteService.initializeDB();
      int count =
          await db.update('emp', empModel.toMap(), where: 'empId = ?', whereArgs: [empModel.empId]);
      debugPrint("Updated Item empId: ${empModel.empId}");
      return count;
    } catch (e) {
      debugPrint("addEmployee: $e");
      return null;
    }
  }

  Future deleteEmployee(int empId) async {
    try {
      final Database db = await sqliteService.initializeDB();
      int count = await db.delete('emp', where: 'empId = ?', whereArgs: [empId]);
      debugPrint("Deleted Item empId: $empId");
      return count;
    } catch (e) {
      debugPrint("addEmployee: $e");
      return null;
    }
  }
}
