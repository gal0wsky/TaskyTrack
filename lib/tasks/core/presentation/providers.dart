import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasky_track/tasks/application/task_name_state_notifier.dart';

import '../../application/task_state_notifier.dart';

final tasksProvider = StateNotifierProvider<TaskStateNotifier, List<TaskState>>(
    (ref) => TaskStateNotifier());

final taskNameProvider =
    StateNotifierProvider<TaskNameStateNotifier, TaskNameState>(
        (ref) => TaskNameStateNotifier());
