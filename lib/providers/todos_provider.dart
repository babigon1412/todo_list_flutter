import 'package:flutter/foundation.dart';
import 'package:todo_list_flutter/models/todos_model.dart';

class TodosProvider with ChangeNotifier {
  List<TodosModel> todos = [];
  int normal = 0;
  int important = 0;

  List<TodosModel> getTodosList() => todos;

  // Used notifylisteners() to communicate with consumer

  void addNormal() {
    normal++;
    notifyListeners();
  }

  void addImportant() {
    important++;
    notifyListeners();
  }

  void add(TodosModel data) {
    todos.insert(0, data);
    notifyListeners();
  }

  void remove(int index) {
    if (todos[index].category == '1') {
      important--;
    } else {
      normal--;
    }
    todos.removeAt(index);
    notifyListeners();
  }
}
