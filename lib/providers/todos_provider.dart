import 'package:flutter/foundation.dart';
import 'package:todo_list_flutter/models/todos_model.dart';

class TodosProvider with ChangeNotifier {
  List<TodosModel> todos = [
    TodosModel(title: 'Spa', category: '0', date: '22-05-2022'),
    TodosModel(title: 'Meeting', category: '1', date: '22-05-2022'),
    TodosModel(title: 'Have a breakfast', category: '1', date: '22-05-2022'),
    TodosModel(title: 'Wake up', category: '0', date: '22-05-2022'),
    TodosModel(title: 'Sleep', category: '1', date: '22-05-2022'),
  ];
  int normal = 2;
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
