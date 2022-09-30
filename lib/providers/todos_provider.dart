import 'package:flutter/foundation.dart';
import 'package:todo_list_flutter/models/todos_model.dart';

class TodosProvider with ChangeNotifier {
  List<TodosModel> todos = [
    TodosModel(title: 'Sleep', category: '0'),
    TodosModel(title: 'Wake up', category: '1'),
    TodosModel(title: 'Having breakfast', category: '1'),
    TodosModel(title: 'Meeting', category: '0'),
    TodosModel(title: 'Appointment with Mr.Kim', category: '0'),
    TodosModel(title: 'Spa', category: '1'),
  ];
  int normal = 3;
  int important = 3;

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
