import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tasky_track/tasks/application/task_state_notifier.dart';

import 'tasks_list_test.mocks.dart';
@GenerateNiceMocks([MockSpec<FlutterSecureStorage>()])

void main() {
  const String _key = "TasksListForTests";

  MockFlutterSecureStorage _storage = MockFlutterSecureStorage();
  TaskStateNotifier _tasks;

  TaskStateNotifier setUpTasks() {
    return TaskStateNotifier(key: _key, storage: _storage);
  }

  group("TaskList tests", () {
    test("Create empty list of tasks", () {
      _tasks = setUpTasks();

      expect(_tasks.state.length, 0);
    });

    test("Add task to list", () async {
      _tasks = setUpTasks();
      
      const task = TaskState();

      final result = await _tasks.addNewTask(title: task.title);

      expect(result, true);
    });

    test("Change task status", () async {
      _tasks = setUpTasks();

      const task = TaskState();

      final result = await _tasks.addNewTask(title: task.title);

      expect(result, true);
      expect(_tasks.state[0].completed, false);

      _tasks.changeTaskStatus(task: task);

      expect(_tasks.state[0].completed, true);
    });

    test("Delete task test", () async {
      _tasks = setUpTasks();

      const task = TaskState();

      final result = await _tasks.addNewTask(title: task.title);

      expect(result, true);
      expect(_tasks.state.length, 1);

      _tasks.deleteTask(task);

      expect(_tasks.state.length, 0 );
    });

    test("Drag task to different position", () async {
      _tasks = setUpTasks();

      const task1 = TaskState();
      const task2 = TaskState(title: "My new task");

      bool result = await _tasks.addNewTask(title: task1.title);

      expect(result, true);

      result = await _tasks.addNewTask(title: task2.title);

      expect(result, true);

      _tasks.reorganizeAfterDrag(oldIndex: 0, newIndex: 1);

      expect(_tasks.state[0].title, task2.title);
      expect(_tasks.state[1].title, task1.title);
    });

    test("Delete single task from list", () async {
      _tasks = setUpTasks();

      const task1 = TaskState();
      const task2 = TaskState(title: "Most important task ever");

      bool result = await _tasks.addNewTask(title: task1.title);
      expect(result, true);

      result = await _tasks.addNewTask(title: task2.title);
      expect(result, true);

      expect(_tasks.state.length, 2);

      _tasks.deleteTask(task2);

      final containsDeletedTask = _tasks.state.contains(task2);

      expect(_tasks.state.length, 1);
      expect(containsDeletedTask, false);
    });

    test("Save tasks list on the device", () async {
      _tasks = setUpTasks();

      const task = TaskState();

      final result = await _tasks.addNewTask(title: task.title);

      expect(result, true);

      await _tasks.saveTasksOnDeviceAsync();
      verify(_storage.write(key: _key, value: _tasks.stateToJson()));
    });

    test("Load tasks list from the device", () async {
      _tasks = setUpTasks();

      const task = TaskState();

      final result = await _tasks.addNewTask(title: task.title);

      expect(result, true);
      expect(_tasks.state.length, 1);

      await _tasks.loadTasksFromStorageAsync();

      expect(_tasks.state.length, 1);
    });

    test("Delete tasks from device storage", () async {
      _tasks = setUpTasks();

      await _tasks.deleteTasksFromStorageAsync();

      verify(_storage.delete(key: _key));
    });
  });
}