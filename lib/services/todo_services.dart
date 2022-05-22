import 'package:mobil_odev_1/models/todo.dart';
import 'package:mobil_odev_1/repositories/repository.dart';

class TodoService {
  Repository? _repository;
  TodoService(){
    _repository = Repository();
  }
  saveTodo(Todo todo ) async{
    return await _repository?.insertDataTodo("todos", todo.todoMap());
  }
  readTodo()async{
    return await _repository?.readDataTodo("todos");
  }
  readTodoId(todoId)async{
    return await _repository?.readDataByIDTodo("todos",todoId);
  }
  updateTodo(Todo todo)async{
    return await _repository?.updateDataTodo("todos",todo.todoMap());
  }
  deleteTodo(todoID)async{
    return await _repository?.deleteDataTodo("todos",todoID);
  }
  readTodosByCat(category)async{
    return await _repository?.readDataByColumnName("todos", "category", category);
  }

}
