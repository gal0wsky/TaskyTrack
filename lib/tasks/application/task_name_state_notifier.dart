import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_name_state_notifier.freezed.dart';

@freezed
class TaskNameState with _$TaskNameState {
  const TaskNameState._();
  const factory TaskNameState({@Default("") String? name}) = _TaskNameState;
}

class TaskNameStateNotifier extends StateNotifier<TaskNameState> {
  TaskNameStateNotifier() : super(const TaskNameState());

  void setTaskName(String newName) {
    state = state.copyWith(name: newName);
  }

  void clearTaskName() {
    state = state.copyWith(name: "");
  }
}
