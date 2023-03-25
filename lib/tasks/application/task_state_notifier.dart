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
  TaskStateNotifier() : super(const []);

  static const String _key = "tasksList";
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

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

  void reorganizeAfterDrag({required int oldIndex, required int newIndex}) {
    if (newIndex > oldIndex) {
      newIndex--;
    }
    
    final oldIndexItem = state[oldIndex];
    final newIndexItem = state[newIndex];

    state = [
      for (final task in state)
        if (task.title == oldIndexItem.title)
          newIndexItem
        else if (task.title == newIndexItem.title)
          oldIndexItem
        else
          task
    ];
  }

  Future<void> saveTasksOnDeviceAsync() async {
    await deleteTasksFromStorageAsync();
    final jsonList = stateToJson();
    final tasksJson = json.encode(jsonList);
    await _storage.write(key: _key, value: tasksJson);
  }

  Future<void> loadTasksFromStorageAsync() async {
    final tasksJson = await _storage.read(key: _key);

    if (tasksJson != null) {
      final tasks = json.decode(tasksJson);

      for (final task in tasks) {
        state = [...state, TaskState.fromJson(task)];
      }
    }
  }

  Future<void> deleteTasksFromStorageAsync() async {
    await _storage.delete(key: _key);
  }

  List stateToJson() {
    List jsonList = [];
    state.map((task) => jsonList.add(task.toJson())).toList();
    return jsonList;
  }
}
