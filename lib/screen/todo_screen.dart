import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobil_odev_1/services/category_services.dart';
//import '../models/category.dart';
import '../models/todo.dart';
import '../services/todo_services.dart';
import 'home_screen.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var _todoTitleController = TextEditingController();
  var _todoDescriptionController = TextEditingController();
  var _todoDateController = TextEditingController();
  var _selectedValue;
  var _categories = <DropdownMenuItem>[];
  var _todo = Todo();
  var _todoService = TodoService();

  @override
  void initState() {
    super.initState();
    //_loadCategories();
  }

  //List<Todo> _todoList = List<Todo>.empty(growable: true);
  //List<Category> _categoryList = List<Category>.empty(growable: true);

 /* _loadCategories() async {
    var _categoryService = CategoryService();
    var categories = _categoryService.readCategories();
    categories.foreach((category) {
      setState(() {
        _categories.add(DropdownMenuItem<String>(
          child: Text(category["name"]),
          value: category["name"],
        ),
        );
      });
    });
  }*/

  DateTime _dateTime = DateTime.now();

  _selectedToDoDate(BuildContext context) async {
    var _pickdate = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    );
    if (_pickdate !=null){
      setState((){
        _dateTime=_pickdate;
        _todoDateController.text=DateFormat("yyyy-MM-dd").format(_pickdate);
      });
    }
  }

  /*getAllCategories() async {
    var categories = await _todoService.readTodo();

    categories?.forEach((todo) {
      setState(() {
        var todoModel = Todo();
        todoModel.tododate = todo["tododate"];
        todoModel.title = todo["title"];
        todoModel.description = todo["description"];
        todoModel.category = todo["category"];
        _todoList.add(todoModel);
      });
    });
  }
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create To Do"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: _todoTitleController,
              decoration: InputDecoration(
                labelText: "title",
                hintText: "write to do title",
              ),
            ),
            TextField(
              controller: _todoDescriptionController,
              decoration: InputDecoration(
                labelText: "Description",
                hintText: "write to do description",
              ),
            ),
            TextField(
              controller: _todoDateController,
              decoration: InputDecoration(
                  labelText: "Date",
                  hintText: "pick a date",
                  prefixIcon: InkWell(
                    onTap: () {
                      _selectedToDoDate(context);
                    },
                    child: Icon(Icons.calendar_today),
                  )),
            ),
            DropdownButton<String>(
              value: _selectedValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                width: double.infinity,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedValue = newValue!;
                });
              },
              items: <String>['Saglik', 'Egitim', 'Is', 'Kisisel'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                //_todo.id = _todoList.length + 1;
                _todo.title = _todoTitleController.text;
                _todo.description = _todoDescriptionController.text;
                _todo.tododate = _todoDateController.text;
                _todo.category =_selectedValue;
                var result = await _todoService.saveTodo(_todo);
                print(_selectedValue);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (Route<dynamic> route) => false);
              },
              child: Text("save"),
            ),
          ],
        ),
      ),
    );
  }
}