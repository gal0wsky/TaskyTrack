import 'package:flutter_test/flutter_test.dart';
import 'package:tasky_track/tasks/application/task_state_notifier.dart';
import 'package:tasky_track/tasks/widgets/task_view.dart';

void main() {
  group("Creating task", () {
    test("Create default task test", () {
      const task = TaskState();

      expect(task.completed, false);
    });

    test("Create valid task test", () {
      const task = TaskState(title: "New Task", completed: false);

      expect(task.completed, false);
    });

    test("Create task with default title test", () {
      const task = TaskState(completed: false);

      expect(task.title, "Clean kitchen");
    });
  });
}