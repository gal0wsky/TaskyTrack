import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tasky_track/tasks/core/presentation/providers.dart';

import '../../tasks/presentation/task_list_view.dart';

final initializationProvider = FutureProvider<void>((ref) async {
  final tasksProvider = ref.read(taskProvider.notifier);
  // await tasksProvider.deleteTasksFromStorageAsync();
  await tasksProvider.loadTasksFromStorageAsync();
});

class AppWidget extends ConsumerWidget {
  AppWidget({super.key});

  final inputFormController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(initializationProvider, (prev, _) {});

    final taskName = ref.watch(taskNameProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("TaskyTrack"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 205, 229, 215),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: inputFormController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "Task name",
                      ),
                      onChanged: (newValue) {
                        ref
                            .read(taskNameProvider.notifier)
                            .setTaskName(newValue);
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: TextButton(
                      onPressed: () async {
                        final taskCreated = await ref
                            .read(taskProvider.notifier)
                            .addNewTask(taskName.name!);

                        if (!taskCreated) {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                      title: const Text("Invalid title"),
                                      content: const Text(
                                          "Please enter valid task title"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("OK"),
                                        ),
                                      ]));
                        } else {
                          ref.read(taskNameProvider.notifier).clearTaskName();
                          inputFormController.clear();
                        }
                      },
                      style: const ButtonStyle(
                        padding: MaterialStatePropertyAll(
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
                        backgroundColor: MaterialStatePropertyAll(Colors.green),
                      ),
                      child: const Text(
                        "ADD",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const TasksListView(),
          ],
        ),
      ),
    );
  }
}