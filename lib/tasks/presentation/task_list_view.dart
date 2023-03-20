import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasky_track/tasks/presentation/task_view.dart';
import '../core/presentation/providers.dart';

class TasksListView extends ConsumerWidget {
  const TasksListView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);

    return ListView.builder(
      shrinkWrap: true,
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return Dismissible(
            key: Key(tasks[index].title),
            onDismissed: (direction) {
              ref.read(taskProvider.notifier).deleteTask(tasks[index]);
            },
            child: TaskView(task: tasks[index]));
      },
    );
  }
}