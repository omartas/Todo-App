import 'package:sqflite/sqflite.dart';

import 'database_connection.dart';

class Repository {
  DatabaseConnection? _databaseConnection;

  //initialize database connection
  Repository() {
    _databaseConnection = DatabaseConnection();
  }

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database ??= await _databaseConnection?.setDatabase();
    return _database;
  }

  //insert data to table

  insertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  readData(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  readDataByID(table, itemId) async {
    var connection = await database;
    return await connection?.query(table,
      where: 'id=?',whereArgs: [itemId]
    );
  }

  updateData(table, data) async {
    var connection = await database;
    return await connection
        ?.update(table, data, where: "id=?", whereArgs: [data["id"]]);
  }

  deleteData(table, itemId) async {
    var connection = await database;
    return await connection
        ?.rawDelete('DELETE FROM $table WHERE id= $itemId');
  }
  deleteTable()async{
    var connection = await database;
    return await connection?.delete("categories");
  }

  insertDataTodo(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  readDataTodo(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  readDataByIDTodo(table, itemId) async {
    var connection = await database;
    return await connection?.query(table,
        where: 'id=?',whereArgs: [itemId]
    );
  }

  updateDataTodo(table, data) async {
    var connection = await database;
    return await connection
        ?.update(table, data, where: "id=?", whereArgs: [data["id"]]);
  }

  deleteDataTodo(table, itemId) async {
    var connection = await database;
    return await connection
        ?.rawDelete('DELETE FROM $table WHERE id= $itemId');
  }

  readDataByColumnName(table,columnName,columnValue)async{
    var connection = await database;
    return await connection?.query(table,where: "$columnName=?",whereArgs: [columnValue]);
  }
}
