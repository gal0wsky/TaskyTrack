import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasky_track/tasks/widgets/task_view.dart';
import '../core/presentation/providers.dart';

class TasksListView extends ConsumerWidget {
  const TasksListView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksProvider);

    return ReorderableListView.builder(
      itemCount: tasks.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(tasks[index].title),
          child: TaskView(task: tasks[index]),
          onDismissed: (direction) {
            ref.read(tasksProvider.notifier).deleteTask(tasks[index]);
          },
        );
      },
      onReorder: ((oldIndex, newIndex) {
        ref.read(tasksProvider.notifier).onTasksReorder(oldIndex: oldIndex, newIndex: newIndex);
      })
    );
  }
}