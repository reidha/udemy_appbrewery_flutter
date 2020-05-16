import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/tasks.dart';
import 'task_tile.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Tasks>(
      builder: (context, tasks, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return TaskTile(
              taskTitle: tasks.tasks[index].name,
              isChecked: tasks.tasks[index].isDone,
              checkboxCallback: (bool value) {
                Provider.of<Tasks>(context, listen: false).toggleDone(index);
              },
              onLongPressCallBack: () {
                Provider.of<Tasks>(context, listen: false).deleteTask(index);
              },
            );
          },
          itemCount: tasks.taskCount,
        );
      },
    );
  }
}
