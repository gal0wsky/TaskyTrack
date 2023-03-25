import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/task_state_notifier.dart';
import '../core/presentation/providers.dart';

class TaskView extends ConsumerWidget {
  const TaskView({super.key, required this.task});

  final TaskState task;

  final TextStyle labelStyle = const TextStyle(
    fontSize: 18,
    color: Colors.white,
  );

  final TextStyle taskComplitedStyle = const TextStyle(
    fontSize: 18,
    color: Colors.white,
    decoration: TextDecoration.lineThrough
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color.fromARGB(255, 38, 187, 11),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                  value: task.completed,
                  checkColor: const Color.fromARGB(255, 38, 187, 11),
                  activeColor: Colors.white,
                  side: MaterialStateBorderSide.resolveWith((states) =>
                      const BorderSide(width: 2.0, color: Colors.white)),
                  onChanged: (_) {
                    ref.read(tasksProvider.notifier).changeTaskStatus(task: task);
                    // TODO: task title is crossed
                  }),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    task.title,
                    style: labelStyle,
                  ),
                ),
              ),
            ],
          ),
        )
      ]
    );
  }
}