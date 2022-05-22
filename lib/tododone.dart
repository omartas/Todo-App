import 'package:flutter/material.dart';
import 'package:mobil_odev_1/services/todo_services.dart';

import 'models/todo.dart';

class ToDoDone extends StatefulWidget {
  final String category;

  ToDoDone({required this.category});

  @override
  State<ToDoDone> createState() => _ToDoDoneState();
}

class _ToDoDoneState extends State<ToDoDone> {
  List<Todo> _todoList = List<Todo>.empty(growable: true);
  TodoService _todoService = TodoService();

  @override
  void initState() {
    super.initState();
    getTodosByCategories();
  }

  getTodosByCategories() async {
    var todos = await _todoService.readTodosByCat(this.widget.category);
    todos.foreach((todo) {
      setState(() {
        print(todo["title"]);
        var model = Todo();
        model.title = todo["title"];
        model.description = todo["description"];
        model.tododate = todo["tododate"];
        _todoList.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.category),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView.builder(
                  itemCount: _todoList.length,
                  itemBuilder: (context, index) {
                   return Card(
                     elevation: 5,
                     child: ListTile(
                       title: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Column(
                             children: [
                               Text(_todoList[index].title.toString()),
                               Text(_todoList[index].category.toString()),
                             ],
                           ),
                           Text(_todoList[index].tododate.toString()),

                         ],
                       ),
                     ),
                   );
                  }),
          )
        ],
      ),
    );
  }
}
