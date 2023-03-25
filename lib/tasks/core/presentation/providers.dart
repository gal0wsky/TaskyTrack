import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tasky_track/tasks/application/task_name_state_notifier.dart';

import '../../application/task_state_notifier.dart';

final secureStorageProvider = Provider((ref) => const FlutterSecureStorage());

final tasksProvider = StateNotifierProvider<TaskStateNotifier, List<TaskState>>(
    (ref) => TaskStateNotifier(key: "TasksList", storage: ref.watch(secureStorageProvider)));

final taskNameProvider =
    StateNotifierProvider<TaskNameStateNotifier, TaskNameState>(
        (ref) => TaskNameStateNotifier());
