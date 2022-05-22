import 'package:flutter/material.dart';
import 'package:mobil_odev_1/helpers/drawer_navigation.dart';
import 'package:mobil_odev_1/models/todo.dart';
import 'package:mobil_odev_1/screen/todo_screen.dart';

import '../services/todo_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  var _todoService = TodoService();

  List<Todo> _todoList = List<Todo>.empty(growable: true);
  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  getAllCategories() async {
    var todos = await _todoService.readTodo();

    todos.forEach((todos) {
      setState(() {
        var todoModel = Todo();
        todoModel.id = todos["id"];
        todoModel.title = todos["title"];
        todoModel.description = todos["description"];
        todoModel.tododate = todos["tododate"];
        todoModel.category = todos["category"];
        _todoList.add(todoModel);
      });
    });
  }


  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TodoScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
      drawer: DrawerNavigation(),
      appBar: AppBar(
        title: Text("To DO List"),
      ),
      body: ListView.builder(
        itemCount: _todoList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 8, left: 16),
            child: Card(
              elevation: 8,
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
                    IconButton(
                      onPressed: () async {
                       // _deleteFormDialog(context, _categoryList[index].id);
                        var result =
                            await _todoService.deleteTodo(_todoList[index].id);
                        //var result1 = await _categoryService.deleteTablee();
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (Route<dynamic>route) => false);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
