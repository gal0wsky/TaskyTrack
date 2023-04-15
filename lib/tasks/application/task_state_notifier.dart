import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';

part 'task_state_notifier.freezed.dart';

@freezed
class TaskState with _$TaskState {
  const TaskState._();

  const factory TaskState({
    @Default("Clean kitchen") String title,
    @Default(false) bool? completed,
  }) = _TaskState;

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "completed": completed
    };
  }

  static TaskState fromJson(Map<String, dynamic> json) {
    return TaskState(title: json["title"], completed: json["completed"]);
  }
}

class TaskStateNotifier extends StateNotifier<List<TaskState>> {
  final String key;
  final FlutterSecureStorage storage;

  TaskStateNotifier({required this.key, required this.storage}) : super(const []);

  Future<bool> addNewTask({required String title}) async {
    final isInList = state.where((t) => t.title == title);

    if (isInList.isNotEmpty || title.isEmpty) {
      return false;
    } else {
      state = [...state, TaskState(title: title, completed: false)];
      await saveTasksOnDeviceAsync();
      return true;
    }
  }

  Future<void> changeTaskStatus({required TaskState task}) async {
    state = [
      for (final item in state)
        if (item.title != task.title)
          item
        else
          TaskState(title: task.title, completed: !task.completed!)
    ];

    await saveTasksOnDeviceAsync();
  }

  void deleteTask(TaskState taskToRemove) async {
    state = [
      for (final task in state)
        if (task.title != taskToRemove.title) task,
    ];

    await saveTasksOnDeviceAsync();
  }

  void onTasksReorder({required int oldIndex, required int newIndex}) {
    List<TaskState> newOrder = [
      for (final task in state) task
    ];

    if (newIndex > oldIndex) {
      newIndex--;

      for (int i=oldIndex+1; i<=newIndex; i++) {
        newOrder[i-1] = newOrder[i];
      }
    }
    else if (newIndex < oldIndex) {
      for (int i=oldIndex; i>newIndex; i--) {
        newOrder[i] = newOrder[i-1];
      }
    }

    final oldIndexItem = state[oldIndex];
    newOrder[newIndex] = oldIndexItem;

    // state = [
    //   for (final task in state)
    //     if (task.title == oldIndexItem.title)
    //       newIndexItem
    //     else if (task.title == newIndexItem.title)
    //       oldIndexItem
    //     else
    //       task
    // ];

    state = newOrder;
  }

  Future<void> saveTasksOnDeviceAsync() async {
    await deleteTasksFromStorageAsync();
    final tasksJson = stateToJson();
    
    await storage.write(key: key, value: tasksJson);
  }

  Future<void> loadTasksFromStorageAsync() async {
    final tasksJson = await storage.read(key: key);

    if (tasksJson != null) {
      final tasks = json.decode(tasksJson);

      for (final task in tasks) {
        state = [...state, TaskState.fromJson(task)];
      }
    }
  }

  Future<void> deleteTasksFromStorageAsync() async {
    await storage.delete(key: key);
  }

  String stateToJson() {
    List jsonList = [];
    state.map((task) => jsonList.add(task.toJson())).toList();

    final tasksJson = json.encode(jsonList);
    return tasksJson;
  }
}
