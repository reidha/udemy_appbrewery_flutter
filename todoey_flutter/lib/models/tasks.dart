import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'task.dart';

class Tasks extends ChangeNotifier {
  List<Task> _tasks = [];

  void toggleDone(int index) {
    _tasks[index].toggleDone();
    notifyListeners();
  }

  void addTask(String name) {
    _tasks.add(Task(name: name));
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }
}
