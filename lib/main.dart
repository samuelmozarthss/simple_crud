import 'package:flutter/material.dart';
import 'database_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SQFlite Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  // referência à nossa classe única que gerencia o banco de dados
  final dbHelper = DatabaseHelper.instance;

  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sqflite'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text(
                'insert',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: _insert,
            ),
            ElevatedButton(
              child: Text(
                'query',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: _query,
            ),
            ElevatedButton(
              child: Text(
                'update',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: _update,
            ),
            ElevatedButton(
              child: Text(
                'delete',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: _delete,
            ),
          ],
        ),
      ),
    );
  }

  // Metodos
  void _insert() async {
    // linha para inserir
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: 'Samuel Mozarth',
      DatabaseHelper.columnAge: 23
    };
    final id = await dbHelper.insert(row);
    print('ID de linha inserido: $id');
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('Consultar todas as linhas:');
    allRows?.forEach(print);
  }

  void _update() async {
    // linha para atualizar
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: 1,
      DatabaseHelper.columnName: 'Mary',
      DatabaseHelper.columnAge: 32
    };
    final rowsAffected = await dbHelper.update(row);
    print('linha(s) $rowsAffected atualizadas');
  }

  void _delete() async {
    // Assumindo que o número de linhas é o id da última linha.
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id!);
    print('Linha(s) $rowsDeleted deletadas: row $id');
  }
}
